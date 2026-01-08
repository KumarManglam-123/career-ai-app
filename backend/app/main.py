from fastapi import FastAPI, UploadFile, File, Form
import shutil
import os

from app.resume_parser import parse_resume_pdf
from app.ats import calculate_ats_score

app = FastAPI()

UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)

@app.post("/upload")
async def upload_resume(
    file: UploadFile = File(...),
    job_description: str = Form("")   # ✅ IMPORTANT: default value
):
    file_path = os.path.join(UPLOAD_DIR, file.filename)

    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)

    resume_data = parse_resume_pdf(file_path)

    ats_score = calculate_ats_score(
        resume_data.get("skills", []),
        job_description or ""
    )

    return {
        "email": resume_data.get("email", ""),
        "phone": resume_data.get("phone", ""),
        "skills": resume_data.get("skills", []),
        "ats_score": ats_score,
        "suggestions": [
            "Add measurable achievements",
            "Match skills with job description",
            "Improve summary section",
            "Add relevant projects"
        ]
    }
import os

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=int(os.environ.get("PORT", 8000)),
    )

