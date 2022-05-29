from cassandra.cluster import Cluster
import json

cluster = Cluster(['0.0.0.0'],port=9042)
session = cluster.connect('twitter_eurovision',wait_for_all_pools=True)
session.execute('USE twitter_eurovision')

res = input("Hit enter to execute query 2: 'How many tweets are associated with each hashtag?'")
hashtags = session.execute("SELECT hashtags FROM tweets;")
hashtags = [h.hashtags for h in hashtags]
hashtag_counts = dict()
for hashtag in hashtags:
    hashtag = hashtag.replace("'", "\"") # JSON expects double quotes 
    hashtag = json.loads(hashtag)
    for h in hashtag:
        h = h['text']
        if h in hashtag_counts.keys():
            hashtag_counts[h] += 1
        else:
            hashtag_counts[h] = 1

print(hashtag_counts)


