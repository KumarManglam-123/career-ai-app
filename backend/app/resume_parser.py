from fastapi import APIRouter, UploadFile, File, Form
from pypdf import PdfReader
import re
import tempfile
import os

router = APIRouter()

def extract_email(text: str):
    match = re.search(r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}", text)
    return match.group(0) if match else ""

def extract_phone(text: str):
    match = re.search(r"\+?\d[\d\s\-]{8,}\d", text)
    return match.group(0) if match else ""

def extract_skills(text: str):
    skills = [
        "python", "java", "c++", "c", "flutter", "dart", "react",
        "machine learning", "ai", "git", "spring boot", "sql", "mongodb"
    ]
    text = text.lower()
    return [s for s in skills if s in text]

@router.post("/upload")
async def upload_resume(
    file: UploadFile = File(...),
    job_description: str = Form("")
):
    if not file.filename.endswith(".pdf"):
        return {"error": "Only PDF files are supported"}

    try:
        # Save PDF temporarily
        with tempfile.NamedTemporaryFile(delete=False, suffix=".pdf") as tmp:
            tmp.write(await file.read())
            tmp_path = tmp.name

        reader = PdfReader(tmp_path)
        full_text = ""

        for page in reader.pages:
            text = page.extract_text()
            if text:
                full_text += text + "\n"

        os.remove(tmp_path)

        if not full_text.strip():
            return {"error": "Could not extract text from PDF"}

        return {
            "email": extract_email(full_text),
            "phone": extract_phone(full_text),
            "skills": extract_skills(full_text),
            "text_preview": full_text[:1000],
            "job_description": job_description
        }

    except Exception as e:
        return {
            "error": "Resume parsing failed",
            "details": str(e)
        }
