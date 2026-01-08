import requests

def fetch_leetcode(username):
    query = {
        "query": """
        query getUserProfile($username: String!) {
          matchedUser(username: $username) {
            submitStats {
              acSubmissionNum {
                difficulty
                count
              }
            }
          }
        }
        """,
        "variables": {"username": username}
    }

    res = requests.post("https://leetcode.com/graphql", json=query)
    return res.json()