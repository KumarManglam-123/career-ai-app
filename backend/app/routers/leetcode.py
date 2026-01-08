from fastapi import APIRouter
from ..services.leetcode_service import fetch_leetcode

router = APIRouter(prefix="/leetcode")

@router.get("/{username}")
def leetcode_profile(username: str):
    return fetch_leetcode(username)