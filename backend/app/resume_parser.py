import pdfplumber
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

    found = []
    for skill in skill_keywords:
        if skill.lower() in text.lower():
            found.append(skill.title())

    return list(set(found))


# ✅ NEW — PROJECT EXTRACTION
def extract_projects(text):
    projects = []
    lines = text.split("\n")

    project_keywords = [
        "project",
        "developed",
        "built",
        "designed",
        "application",
        "system",
        "app",
        "website"
    ]

    for line in lines:
        line_clean = line.strip()
        if any(k.lower() in line_clean.lower() for k in project_keywords):
            if len(line_clean) > 15:
                projects.append(line_clean)

    return list(dict.fromkeys(projects))[:5]


def calculate_ats_score(skills, job_description):
    if not job_description:
        return 20

    jd = job_description.lower()
    matched = sum(1 for s in skills if s.lower() in jd)
    return min(100, 20 + matched * 10)


def get_suggestions(skills, ats_score):
    suggestions = []

    if ats_score < 40:
        suggestions.append("Add measurable achievements")
        suggestions.append("Match skills with job description")
        suggestions.append("Improve summary section")

    if len(skills) < 5:
        suggestions.append("Add more relevant skills")

    suggestions.append("Add relevant projects")

    return suggestions


def parse_resume_pdf(file_path, job_description=""):
    text = ""

    with pdfplumber.open(file_path) as pdf:
        for page in pdf.pages:
            text += page.extract_text() + "\n"

    email = extract_email(text)
    phone = extract_phone(text)
    skills = extract_skills(text)
    projects = extract_projects(text)
    ats_score = calculate_ats_score(skills, job_description)
    suggestions = get_suggestions(skills, ats_score)

    return {
        "email": email,
        "phone": phone,
        "skills": skills,
        "projects": projects,      # ✅ PROJECTS SENT TO FLUTTER
        "ats_score": ats_score,
        "suggestions": suggestions
    }
