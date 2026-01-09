from fastapi import APIRouter, UploadFile, File
from pypdf import PdfReader
import re
import shutil
import os
import uuid

router = APIRouter()

@router.post("/upload")
async def upload_resume(file: UploadFile = File(...)):
    UPLOAD_DIR = "uploads"
    os.makedirs(UPLOAD_DIR, exist_ok=True)



# ---------- Helper functions ----------
def extract_email(text):
    match = re.search(r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}", text)
    return match.group(0) if match else ""


def extract_phone(text):
    match = re.search(r"\+?\d[\d\s-]{8,}\d", text)
    return match.group(0) if match else ""


def extract_skills(text):
    skill_keywords = [
        "python", "java", "c++", "c", "flutter", "dart", "react",
        "machine learning", "ai", "git", "spring boot", "sql", "mongodb"
    ]
    text_lower = text.lower()
    return [skill for skill in skill_keywords if skill in text_lower]


def parse_resume_pdf(file_path: str):
    reader = PdfReader(file_path)
    full_text = ""

    for page in reader.pages:
        if page.extract_text():
            full_text += page.extract_text() + "\n"

    return {
        "email": extract_email(full_text),
        "phone": extract_phone(full_text),
        "skills": extract_skills(full_text),
        "text": full_text.strip()
    }


# ---------- API endpoint ----------
@router.post("/upload")
async def upload_resume(file: UploadFile = File(...)):
    if not file.filename.endswith(".pdf"):
        return {"error": "Only PDF files are supported"}

    file_id = f"{uuid.uuid4()}.pdf"
    file_path = os.path.join(UPLOAD_DIR, file_id)

    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    parsed_data = parse_resume_pdf(file_path)

    return {
        "filename": file.filename,
        "parsed_data": parsed_data
    }
