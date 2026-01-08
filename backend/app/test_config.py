from app.config import settings

print("OpenAI key loaded:", settings.openai_api_key[:10])
print("MongoDB URI:", settings.mongodb_uri)
