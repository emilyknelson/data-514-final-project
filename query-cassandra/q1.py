from cassandra.cluster import Cluster
import json

cluster = Cluster(['0.0.0.0'],port=9042)
session = cluster.connect('twitter_eurovision',wait_for_all_pools=True)
session.execute('USE twitter_eurovision')

res = input("Hit enter to execute query 1: 'Which user has posted the most tweets?'")
rows = session.execute('SELECT user_id, COUNT(*) FROM tweets GROUP BY user_id LIMIT 3000;')
most_active_users = []
max_tweets = 0
for row in rows:
    try:
        if row.count >= max_tweets:
            max_tweets = row.count
            most_active_users = []
            most_active_users.append(row.user_id)
    except: 
        breakpoint()

print(f"Most tweets posted is {max_tweets}, by user {most_active_users}")
