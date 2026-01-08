from fastapi import APIRouter, UploadFile, File, Form
import shutil
import os

from app.resume_parser import parse_resume_pdf

router = APIRouter()

UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)


@router.post("/upload")
async def upload_resume(
    file: UploadFile = File(...),
    job_description: str = Form("")
):
    file_path = os.path.join(UPLOAD_DIR, file.filename)

    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    result = parse_resume_pdf(file_path, job_description)

    return result
