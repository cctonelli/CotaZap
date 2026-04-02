from pydantic import BaseModel, EmailStr, Field
from typing import Optional, List, Dict
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
    created_at: datetime
    
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
    created_at: datetime
    
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
    created_at: datetime
    
    class Config:
        from_attributes = True
