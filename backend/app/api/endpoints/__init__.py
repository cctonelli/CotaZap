from fastapi import APIRouter
from app.api.endpoints import buyers, suppliers, webhooks

api_router = APIRouter()

api_router.include_router(buyers.router, prefix="/buyers", tags=["compradores"])
api_router.include_router(suppliers.router, prefix="/suppliers", tags=["fornecedores"])
api_router.include_router(webhooks.router, prefix="/webhooks", tags=["webhooks"])
