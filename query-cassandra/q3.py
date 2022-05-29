from cassandra.cluster import Cluster
import json

cluster = Cluster(['0.0.0.0'],port=9042)
session = cluster.connect('twitter_eurovision',wait_for_all_pools=True)
session.execute('USE twitter_eurovision')

response = input("Hit enter to run query 'For each verified user, what is the percentage of each type of tweet?'")
rows = session.execute("SELECT user_id, tweet, in_reply_to_user_id FROM tweets WHERE is_verified = 1 ALLOW FILTERING;")
result = dict()
for row in rows:
    """
    The rules for classifying tweets are:
    1. If "RT" appears in "tweet", it's a retweet
    2. If "in_reply_to_user_id" exists, it's a response
    3. If "quote" appears in tweet, it's a quote
    4. Otherwise, it's a simple tweet
    """
    user_id = row.user_id
    if user_id not in result.keys():
        result[user_id] = {
            'retweets': 0,
            'responses': 0,
            'quotes': 0,
            'simple': 0,
        } # Value is a dictionary of types of tweets
    if "RT" in row.tweet:
        result[user_id]['retweets'] += 1
    elif row.in_reply_to_user_id:
        result[user_id]['responses'] += 1
    elif "quote" in row.tweet:
        result[user_id]['quotes'] += 1
    else:
        result[user_id]['simple'] += 1

print(result)
