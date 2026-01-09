import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# Import routers
from app.routers.ats import router as ats_router
from app.routers.upload import router as upload_router

app = FastAPI(
    title="Career AI Backend",
    version="1.0.0"
)

# =========================
# CORS CONFIG (VERY IMPORTANT)
# =========================
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # allow all for now (OK for demo)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Health check
@app.get("/")
def root():
    return {
        "status": "ok",
        "message": "Career AI backend running"
    }

# Register routers
app.include_router(ats_router, prefix="/ats", tags=["ATS"])
app.include_router(upload_router, prefix="/resume", tags=["Resume"])
