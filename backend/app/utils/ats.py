def calculate_ats_score(resume_skills, job_description):
    if not resume_skills or not job_description:
        return 0

    jd = job_description.lower()
    matched = 0

    for skill in resume_skills:
        if skill.lower() in jd:
            matched += 1

    return round((matched / len(resume_skills)) * 100)
