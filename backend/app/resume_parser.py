from pypdf import PdfReader
import re

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
