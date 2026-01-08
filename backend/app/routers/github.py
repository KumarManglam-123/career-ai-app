from fastapi import APIRouter
from ..services.github_service import fetch_github_profile

router = APIRouter(prefix="/github")

@router.get("/{username}")
def github_profile(username: str):
    return fetch_github_profile(username)