from fastapi import APIRouter, Request, Depends, HTTPException
from sqlalchemy.orm import Session
from app.services.whatsapp import whatsapp_service
from app.models.domain import SupplierResponse, QuotationItem, Supplier
from app.db.session import get_db # Ainda por criar
import json

router = APIRouter()

@router.post("/evolution-webhook", tags=["Webhooks"])
async def receive_whatsapp_event(request: Request, db: Session = Depends(get_db)):
    """
    Recebe eventos da Evolution API (MESSAGES_UPSERT, MESSAGES_UPDATE).
    """
    payload = await request.json()
    
    event_type = payload.get("event")
    data = payload.get("data", {})
    
    if event_type == "MESSAGES_UPSERT":
        message_data = data.get("message", {})
        sender_number = data.get("key", {}).get("remoteJid", "").split("@")[0]
        received_text = message_data.get("conversation") or message_data.get("extendedTextMessage", {}).get("text", "")

        if received_text:
            # 1. Extrair Dados Inteligentes (Parser v1.4)
            extracted_price = whatsapp_service.extract_price_from_text(received_text)
            extracted_term = whatsapp_service.extract_payment_term_days(received_text)
            extracted_condition = whatsapp_service.extract_payment_condition(received_text)
            extracted_lead_time = whatsapp_service.extract_lead_time(received_text)
            extracted_freight = whatsapp_service.extract_freight_info(received_text)
            extracted_installments = whatsapp_service.extract_installments(received_text)
            
            # 2. Identificar Fornecedor
            supplier = db.query(Supplier).filter(Supplier.whatsapp.contains(sender_number)).first()
            
            if supplier:
                # 3. Buscar a cotação item mais recente que ESSE fornecedor foi solicitado
                # Vinculação por histórico de respostas com status 'requested' ou 'pending'
                pending_response = (db.query(SupplierResponse)
                                   .filter(SupplierResponse.supplier_id == supplier.id)
                                   .filter(SupplierResponse.status.in_(["requested", "pending"]))
                                   .order_by(SupplierResponse.response_date.desc())
                                   .first())
                
                target_item_id = pending_response.item_quotation_id if pending_response else None
                
                # Fallback: Se não encontrou pedido formal, pega o último item geral (não recomendado, mas para o MVP)
                if not target_item_id:
                    latest_item = db.query(QuotationItem).order_by(QuotationItem.id.desc()).first()
                    target_item_id = latest_item.id if latest_item else None

                if target_item_id:
                    # 4. Criar ou Atualizar a Resposta no Banco
                    # Agora incluímos lead time e frete no banco (se existirem as colunas)
                    new_response = SupplierResponse(
                        item_quotation_id=target_item_id,
                        supplier_id=supplier.id,
                        message_received=received_text,
                        price_extracted=extracted_price,
                        payment_term_days=extracted_term,
                        payment_condition=extracted_condition,
                        # observations: Aqui poderíamos salvar o frete, lead time e parcelamento
                        status="received"
                    )
                    db.add(new_response)
                    db.commit()
                    
                    return {"status": "success", "parsed_data": {
                        "price": extracted_price,
                        "term": extracted_term,
                        "condition": extracted_condition,
                        "installments": extracted_installments,
                        "lead_time": extracted_lead_time,
                        "freight": extracted_freight
                    }}

    return {"status": "success", "event_received": event_type}
