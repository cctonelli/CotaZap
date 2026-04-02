from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List, Optional
from app.db.session import get_db
from app.models.domain import Supplier
from app.schemas.domain import SupplierCreate, SupplierRead

router = APIRouter()

@router.get("/", response_model=List[SupplierRead])
def read_suppliers(
    active: Optional[bool] = None,
    skip: int = 0, 
    limit: int = 100, 
    db: Session = Depends(get_db)
):
    query = db.query(Supplier)
    if active is not None:
        query = query.filter(Supplier.active == active)
    
    suppliers = query.offset(skip).limit(limit).all()
    return suppliers

@router.post("/", response_model=SupplierRead, status_code=status.HTTP_201_CREATED)
def create_supplier(supplier_in: SupplierCreate, db: Session = Depends(get_db)):
    db_supplier = Supplier(
        trade_name=supplier_in.trade_name,
        whatsapp=supplier_in.whatsapp,
        address=supplier_in.address,
        observations=supplier_in.observations,
        active=supplier_in.active
    )
    db.add(db_supplier)
    db.commit()
    db.refresh(db_supplier)
    return db_supplier

@router.get("/{supplier_id}", response_model=SupplierRead)
def read_supplier(supplier_id: int, db: Session = Depends(get_db)):
    db_supplier = db.query(Supplier).filter(Supplier.id == supplier_id).first()
    if not db_supplier:
        raise HTTPException(status_code=404, detail="Fornecedor não encontrado")
    return db_supplier

@router.patch("/{supplier_id}", response_model=SupplierRead)
def update_supplier(supplier_id: int, supplier_in: SupplierCreate, db: Session = Depends(get_db)):
    db_supplier = db.query(Supplier).filter(Supplier.id == supplier_id).first()
    if not db_supplier:
        raise HTTPException(status_code=404, detail="Fornecedor não encontrado")
    
    update_data = supplier_in.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_supplier, key, value)
    
    db.add(db_supplier)
    db.commit()
    db.refresh(db_supplier)
    return db_supplier

@router.delete("/{supplier_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_supplier(supplier_id: int, db: Session = Depends(get_db)):
    db_supplier = db.query(Supplier).filter(Supplier.id == supplier_id).first()
    if not db_supplier:
        raise HTTPException(status_code=404, detail="Fornecedor não encontrado")
    db.delete(db_supplier)
    db.commit()
    return None
