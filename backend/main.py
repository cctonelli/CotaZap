from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.endpoints import api_router

app = FastAPI(title="CotaZap Backend", version="1.0.0")

app.include_router(api_router)

@app.get("/")
def read_root():
    return {"message": "CotaZap Backend is running"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
