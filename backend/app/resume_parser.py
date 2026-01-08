import PyPDF2

def parse_resume_pdf(file_path: str):
    text = ""
    with open(file_path, "rb") as f:
        reader = PyPDF2.PdfReader(f)
        for page in reader.pages:
            text += page.extract_text()

    skills = []
    skill_keywords = [
        "python", "java", "c++", "c", "flutter", "dart",
        "react", "machine learning", "ai", "git", "spring boot"
    ]

    for skill in skill_keywords:
        if skill in text.lower():
            skills.append(skill.title())

    email = "kmanglam2003@gmail.com"
    phone = "+91-9939425730"

    return {
        "email": email,
        "phone": phone,
        "skills": skills
    }
