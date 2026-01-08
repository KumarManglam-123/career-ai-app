import requests

def fetch_github_profile(username):
    user = requests.get(f"https://api.github.com/users/{username}").json()
    repos = requests.get(user["repos_url"]).json()

    return {
        "name": user.get("name"),
        "repos": len(repos),
        "followers": user.get("followers")
    }