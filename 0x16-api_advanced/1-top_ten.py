#!/usr/bin/python3
"""this api requests for the tp ten hot posts"""
import requests


def top_ten(subreddit):
    """
    Queries the Reddit API and prints the titles of 
    the first 10 hot posts listed for a given subreddit.
    If an invalid subreddit is given, the function prints None.
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"
    headers = {'User-Agent': 'popular_api_hot'}
    
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code != 200:
        print(None)
        return

    data = response.json().get('data', {}).get('children', [])
 
    for post in data:
        print(post.get('data', {}).get('title'))
