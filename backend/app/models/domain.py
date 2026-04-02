from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, ForeignKey, Float, JSON
from sqlalchemy.orm import declarative_base, relationship
from datetime import datetime

Base = declarative_base()

class Buyer(Base):
    __tablename__ = "buyers"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    company = Column(String(255), nullable=False)
    whatsapp = Column(String(50), nullable=False)
    email = Column(String(255), nullable=True)
    role = Column(String(100), nullable=True) # cargo
    
    quotations = relationship("Quotation", back_populates="buyer")

class Supplier(Base):
    __tablename__ = "suppliers"
    id = Column(Integer, primary_key=True, index=True)
    trade_name = Column(String(255), nullable=False) # nome_fantasia
    whatsapp = Column(String(50), nullable=False)
    address = Column(Text, nullable=True)
    observations = Column(Text, nullable=True)
    active = Column(Boolean, default=True)

    products = relationship("Product", secondary="product_suppliers", back_populates="suppliers")

class Product(Base):
    __tablename__ = "products"
    id = Column(Integer, primary_key=True, index=True)
    sku = Column(String(100), nullable=True)
    description = Column(Text, nullable=False)
    unit_measure = Column(String(50), nullable=False) # unidade_medida
    packaging_type = Column(String(100), nullable=False) # tipo_embalagem
    attributes = Column(JSON, nullable=True) # atributos_json

    suppliers = relationship("Supplier", secondary="product_suppliers", back_populates="products")

class ProductSupplier(Base):
    __tablename__ = "product_suppliers"
    id = Column(Integer, primary_key=True, index=True)
    product_id = Column(Integer, ForeignKey("products.id"))
    supplier_id = Column(Integer, ForeignKey("suppliers.id"))

class Quotation(Base):
    __tablename__ = "quotations"
    id = Column(Integer, primary_key=True, index=True)
    buyer_id = Column(Integer, ForeignKey("buyers.id"))
    date = Column(DateTime, default=datetime.utcnow)
    status = Column(String(50), default="pending")
    template_message = Column(Text, nullable=True)

    buyer = relationship("Buyer", back_populates="quotations")
    items = relationship("QuotationItem", back_populates="quotation")

class QuotationItem(Base):
    __tablename__ = "quotation_items"
    id = Column(Integer, primary_key=True, index=True)
    quotation_id = Column(Integer, ForeignKey("quotations.id"))
    product_id = Column(Integer, ForeignKey("products.id"))
    quantity = Column(Float, nullable=False)
    requested_price = Column(Float, nullable=True)
    delivery_type = Column(String(50), nullable=True)
    desired_lead_time = Column(Integer, nullable=True) # prazo_desejado em dias

    quotation = relationship("Quotation", back_populates="items")
    responses = relationship("SupplierResponse", back_populates="item")

class SupplierResponse(Base):
    __tablename__ = "supplier_responses"
    id = Column(Integer, primary_key=True, index=True)
    item_quotation_id = Column(Integer, ForeignKey("quotation_items.id"))
    supplier_id = Column(Integer, ForeignKey("suppliers.id"))
    message_received = Column(Text, nullable=True)
    price_extracted = Column(Float, nullable=True)
    payment_term_days = Column(Integer, nullable=True)
    payment_condition = Column(String(255), nullable=True)
    early_discount_percent = Column(Float, nullable=True)
    response_date = Column(DateTime, default=datetime.utcnow)
    status = Column(String(50), default="received")

    item = relationship("QuotationItem", back_populates="responses")
