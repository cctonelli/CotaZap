from pydantic import BaseModel, EmailStr, Field
from typing import Optional, List, Dict, Any
from datetime import datetime

# --- BUYER SCHEMAS ---

class BuyerBase(BaseModel):
    name: str
    company: str
    whatsapp: str
    email: Optional[EmailStr] = None
    role: Optional[str] = None

class BuyerCreate(BuyerBase):
    pass

class BuyerUpdate(BaseModel):
    name: Optional[str] = None
    company: Optional[str] = None
    whatsapp: Optional[str] = None
    email: Optional[EmailStr] = None
    role: Optional[str] = None

class BuyerRead(BuyerBase):
    id: int

    class Config:
        from_attributes = True

# --- SUPPLIER SCHEMAS ---

class SupplierBase(BaseModel):
    trade_name: str
    whatsapp: str
    address: Optional[str] = None
    observations: Optional[str] = None
    active: bool = True

class SupplierCreate(SupplierBase):
    pass

class SupplierRead(SupplierBase):
    id: int

    class Config:
        from_attributes = True

# --- PRODUCT SCHEMAS ---

class ProductBase(BaseModel):
    sku: Optional[str] = None
    description: str
    unit_measure: str
    packaging_type: str
    attributes: Optional[Dict] = None

class ProductRead(ProductBase):
    id: int

    class Config:
        from_attributes = True

# --- SEND QUOTATION SCHEMAS ---

class SupplierDispatch(BaseModel):
    """Dados mínimos de um fornecedor para disparo de WhatsApp."""
    trade_name: str = Field(..., description="Nome fantasia do fornecedor")
    whatsapp: str = Field(..., description="Número WhatsApp do fornecedor (com DDI)")
    message: Optional[str] = Field(None, description="Mensagem personalizada para este fornecedor")


class SendQuotationRequest(BaseModel):
    """
    Payload enviado pelo Flutter quando o comprador aperta "Enviar Cotação".
    V1.5: Inclui buyer_id e suporte a mensagens por fornecedor.
    """
    quotation_id: int = Field(..., description="ID da cotação criada no banco local")
    buyer_id: str = Field(..., description="UUID do comprador (Supabase)")
    message: Optional[str] = Field(None, description="Mensagem padrão (caso não haja por fornecedor)")
    suppliers: List[SupplierDispatch] = Field(
        ...,
        description="Lista de fornecedores com nome e WhatsApp para disparo.",
    )
    evolution_instance: Optional[str] = Field(
        default=None,
        description="Instância da Evolution API (usa a padrão se omitido).",
    )
    buyer_whatsapp: Optional[str] = Field(
        default=None,
        description="Número do comprador para confirmação (opcional).",
    )


class SendQuotationResponse(BaseModel):
    """Retorno do endpoint de disparo para o app Flutter."""
    quotation_id: int
    total_suppliers: int
    sent: int
    failed: int
    details_sent: List[Dict[str, Any]] = []
    details_failed: List[Dict[str, Any]] = []
