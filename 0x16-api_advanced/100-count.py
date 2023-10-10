#!/usr/bin/python3
"""recursive fetch hot articles of specific title and count"""
import requests
from collections import Counter
import re


def count_words(subreddit, word_list, after=None, word_count=Counter()):
    """
    Recursive function that queries the Reddit API,
    parses the title of all hot articles,
    and prints a sorted count of given keywords.
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {'User-Agent': 'custom'}
    params = {'limit': 100, 'after': after}

    response = requests.get(url, headers=headers,
                            params=params,
                            allow_redirects=False)

    if response.status_code != 200:
        return

    data = response.json().get('data', {})

    titles = [post.get('data', {}).get('title')
              for post in data.get('children', [])]

    for title in titles:
        words = re.findall(r'\b\w+\b', title.lower())
        for word in words:
            if word in word_list:
                word_count[word] += 1

    after = data.get('after')

    if after is not None:
        return count_words(subreddit, word_list, after, word_count)

    sorted_word_count = sorted(word_count.items(),
                               key=lambda x: (-x[1], x[0]))

    for word, count in sorted_word_count:
        print(f'{word}: {count}')
