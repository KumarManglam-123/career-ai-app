import os
from fastapi import FastAPI

app = FastAPI()

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

if not OPENAI_API_KEY:
    print("INFO: OPENAI_API_KEY not set, running without OpenAI features")
