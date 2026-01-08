from fastapi import APIRouter
from ..services.rag import get_chat_response

router = APIRouter(prefix="/chat")

@router.post("/")
def chat(query: str, doc_id: str):
    return get_chat_response(query, doc_id)