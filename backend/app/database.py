import sqlite3

# Create / connect DB
conn = sqlite3.connect("resumes.db", check_same_thread=False)
cursor = conn.cursor()

# Create table
cursor.execute("""
CREATE TABLE IF NOT EXISTS resumes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT,
    phone TEXT,
    skills TEXT,
    ats_score INTEGER
)
""")

conn.commit()
