# Career AI – Resume & Offer Letter Intelligence App

AI-powered mobile app that:
- Parses offer letters and resumes
- Extracts structured employment data
- Enables conversational AI (RAG) over documents
- Integrates GitHub & LeetCode for career insights

## Tech Stack
- Flutter
- FastAPI
- LangChain
- OpenAI
- FAISS
- MongoDB
- Docker

## Features
- Offer letter parsing
- Resume chatbot
- GitHub profile analysis
- LeetCode DSA analysis

## Setup

### Backend
1. Navigate to `backend/`
2. Install dependencies: `pip install -r requirements.txt`
3. Set up `.env` with your API keys
4. Run with Docker: `docker-compose up --build`

### Mobile App
1. Navigate to `mobile_app/`
2. Run `flutter pub get`
3. Run `flutter run`

## Deployment
- Backend: Deploy to Render or AWS
- Mobile: Build and submit to app stores