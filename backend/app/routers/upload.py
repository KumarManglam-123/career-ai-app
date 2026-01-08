from fastapi import APIRouter, UploadFile, File
import os
import shutil

from app.resume_parser import parse_resume_pdf

router = APIRouter()

UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)


@router.post("/parse-resume")
async def parse_resume(file: UploadFile = File(...)):
    file_path = os.path.join(UPLOAD_DIR, file.filename)

    # Save uploaded file
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    # Parse resume
    parsed_data = parse_resume_pdf(file_path)

    return {
        "filename": file.filename,
        "parsed_data": parsed_data
    }
