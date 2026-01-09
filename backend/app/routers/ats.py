from fastapi import APIRouter
from pydantic import BaseModel
from typing import List

router = APIRouter()

class ATSRequest(BaseModel):
    resume_skills: List[str]
    job_description: str

@router.post("/score")
def calculate_ats(data: ATSRequest):
    jd = data.job_description.lower()

    matched_skills = [
        s for s in data.resume_skills if s.lower() in jd
    ]

    score = (
        round((len(matched_skills) / len(data.resume_skills)) * 100)
        if data.resume_skills else 0
    )

    return {
        "ats_score": score,
        "matched_skills": matched_skills
    }
