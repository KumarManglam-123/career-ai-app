from pydantic import BaseModel

class GitHubProfile(BaseModel):
    name: str
    repos: int
    followers: int