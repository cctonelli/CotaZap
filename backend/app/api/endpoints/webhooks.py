from fastapi import APIRouter, Request, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List, Optional
from app.services.whatsapp import whatsapp_service
from app.models.domain import SupplierResponse, QuotationItem, Supplier
from app.schemas.domain import SendQuotationRequest, SendQuotationResponse
from app.db.session import get_db

router = APIRouter()


# =============================================================================
# DISPARO — Comprador aperta "Enviar Cotação" → envia WhatsApp para fornecedores
# =============================================================================

@router.post(
    "/send-quotation",
    response_model=SendQuotationResponse,
    status_code=status.HTTP_200_OK,
    summary="Dispara WhatsApp de cotação para os fornecedores selecionados",
    tags=["Disparo WhatsApp"],
)
async def send_quotation_to_suppliers(
    payload: SendQuotationRequest,
):
    """
    Recebe a requisição do app Flutter quando o comprador aperta "Enviar Cotação".
    O Flutter já envia a lista de fornecedores com nome e WhatsApp.
    O backend apenas orquestra o disparo via Evolution API.
    Não precisa consultar banco próprio — os dados vêm do Drift/Supabase do app.
    """
    if not payload.message or not payload.message.strip():
        raise HTTPException(
            status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
            detail="A mensagem da cotação não pode estar vazia.",
        )

    if not payload.suppliers:
        raise HTTPException(
            status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
            detail="É necessário informar ao menos um fornecedor para disparar.",
        )

    # Converter para dict para o serviço de WhatsApp
    suppliers_data = [
        {"whatsapp": s.whatsapp, "trade_name": s.trade_name}
        for s in payload.suppliers
    ]

    # Disparar mensagens via Evolution API
    result = await whatsapp_service.send_quotation_to_suppliers(
        suppliers=suppliers_data,
        message=payload.message,
        instance=payload.evolution_instance,
    )

    print(
        f"📨 Cotação {payload.quotation_id} disparada: "
        f"{result['sent']}/{result['total']} mensagens enviadas."
    )

    return SendQuotationResponse(
        quotation_id=payload.quotation_id,
        total_suppliers=result["total"],
        sent=result["sent"],
        failed=result["failed"],
        details_sent=result["details_sent"],
        details_failed=result["details_failed"],
    )


# =============================================================================
# RECEPÇÃO — Evolution API → Webhook de respostas dos fornecedores
# =============================================================================

@router.post(
    "/evolution-webhook",
    summary="Recebe eventos da Evolution API (MESSAGES_UPSERT, etc.)",
    tags=["Webhooks"],
)
async def receive_whatsapp_event(request: Request, db: Session = Depends(get_db)):
    """
    Recebe eventos da Evolution API (MESSAGES_UPSERT, MESSAGES_UPDATE).
    Extrai preço, prazo, condição e salva a resposta do fornecedor no banco.
    """
    payload = await request.json()

    event_type = payload.get("event")
    data = payload.get("data", {})

    if event_type == "MESSAGES_UPSERT":
        message_data = data.get("message", {})
        sender_number = data.get("key", {}).get("remoteJid", "").split("@")[0]
        received_text = (
            message_data.get("conversation")
            or message_data.get("extendedTextMessage", {}).get("text", "")
        )

        if received_text:
            # 1. Extrair dados inteligentes
            extracted_price = whatsapp_service.extract_price_from_text(received_text)
            extracted_term = whatsapp_service.extract_payment_term_days(received_text)
            extracted_condition = whatsapp_service.extract_payment_condition(received_text)
            extracted_lead_time = whatsapp_service.extract_lead_time(received_text)
            extracted_freight = whatsapp_service.extract_freight_info(received_text)
            extracted_installments = whatsapp_service.extract_installments(received_text)

            # 2. Identificar Fornecedor pelo número
            supplier = (
                db.query(Supplier)
                .filter(Supplier.whatsapp.contains(sender_number))
                .first()
            )

            if supplier:
                # 3. Buscar a resposta de cotação pendente mais recente deste fornecedor
                pending_response = (
                    db.query(SupplierResponse)
                    .filter(SupplierResponse.supplier_id == supplier.id)
                    .filter(SupplierResponse.status.in_(["requested", "pending"]))
                    .order_by(SupplierResponse.response_date.desc())
                    .first()
                )

                target_item_id = (
                    pending_response.item_quotation_id if pending_response else None
                )

                # Fallback: último item de cotação cadastrado
                if not target_item_id:
                    latest_item = (
                        db.query(QuotationItem)
                        .order_by(QuotationItem.id.desc())
                        .first()
                    )
                    target_item_id = latest_item.id if latest_item else None

                if target_item_id:
                    # 4. Registrar resposta no banco
                    new_response = SupplierResponse(
                        item_quotation_id=target_item_id,
                        supplier_id=supplier.id,
                        message_received=received_text,
                        price_extracted=extracted_price,
                        payment_term_days=extracted_term,
                        payment_condition=extracted_condition,
                        status="received",
                    )
                    db.add(new_response)
                    db.commit()

                    return {
                        "status": "success",
                        "parsed_data": {
                            "price": extracted_price,
                            "term": extracted_term,
                            "condition": extracted_condition,
                            "installments": extracted_installments,
                            "lead_time": extracted_lead_time,
                            "freight": extracted_freight,
                        },
                    }

    return {"status": "success", "event_received": event_type}
