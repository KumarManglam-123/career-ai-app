import os
from fastapi import FastAPI

# Import routers
from app.routers.ats import router as ats_router
from app.routers.upload import router as upload_router

app = FastAPI(
    title="Career AI Backend",
    version="1.0.0"
)

# Optional OpenAI key check
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
if not OPENAI_API_KEY:
    print("INFO: OPENAI_API_KEY not set, running without OpenAI features")

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
