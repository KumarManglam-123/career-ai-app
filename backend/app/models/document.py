from pydantic import BaseModel

class Document(BaseModel):
    id: str
    user_id: str
    type: str  # 'resume' or 'offer_letter'
    content: str