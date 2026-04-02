from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from app.db.session import get_db
from app.models.domain import Buyer
from app.schemas.domain import BuyerCreate, BuyerRead, BuyerUpdate

router = APIRouter()

@router.get("/", response_model=List[BuyerRead])
def read_buyers(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    buyers = db.query(Buyer).offset(skip).limit(limit).all()
    return buyers

@router.post("/", response_model=BuyerRead, status_code=status.HTTP_210_CREATED)
def create_buyer(buyer_in: BuyerCreate, db: Session = Depends(get_db)):
    db_buyer = Buyer(
        name=buyer_in.name,
        company=buyer_in.company,
        whatsapp=buyer_in.whatsapp,
        email=buyer_in.email,
        role=buyer_in.role
    )
    db.add(db_buyer)
    db.commit()
    db.refresh(db_buyer)
    return db_buyer

@router.get("/{buyer_id}", response_model=BuyerRead)
def read_buyer(buyer_id: int, db: Session = Depends(get_db)):
    db_buyer = db.query(Buyer).filter(Buyer.id == buyer_id).first()
    if not db_buyer:
        raise HTTPException(status_code=404, detail="Comprador não encontrado")
    return db_buyer

@router.patch("/{buyer_id}", response_model=BuyerRead)
def update_buyer(buyer_id: int, buyer_in: BuyerUpdate, db: Session = Depends(get_db)):
    db_buyer = db.query(Buyer).filter(Buyer.id == buyer_id).first()
    if not db_buyer:
        raise HTTPException(status_code=404, detail="Comprador não encontrado")
    
    update_data = buyer_in.dict(exclude_unset=True)
    for key, value in update_data.items():
        setattr(db_buyer, key, value)
    
    db.add(db_buyer)
    db.commit()
    db.refresh(db_buyer)
    return db_buyer

@router.delete("/{buyer_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_buyer(buyer_id: int, db: Session = Depends(get_db)):
    db_buyer = db.query(Buyer).filter(Buyer.id == buyer_id).first()
    if not db_buyer:
        raise HTTPException(status_code=404, detail="Comprador não encontrado")
    db.delete(db_buyer)
    db.commit()
    return None
