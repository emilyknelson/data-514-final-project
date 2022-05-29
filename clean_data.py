import json
import pandas as pd

f = open('raw-data/Eurovision3.json', 'r')
records = f.readlines()

cleaned_data = []
i = 0
for record in records:
    record = record.strip()
    user_id_map = {}
    if record: # Many of the lines in the file are empty. Ignore these.
        try:
            record = json.loads(record)
            
            user_id = record['user']['id']
            if user_id not in user_id_map.keys():
                user_id_map[user_id] = i
            flattened_record = {
                'created_at': record['created_at'],
                'tweet_id': i, #The actual tweet ID is too large to be stored as an int in Cassandra. 
                'user_id': user_id_map[user_id], #Same issue with too-large integer
                'tweet': record['text'],
                'screen_name': record['user']['screen_name'],
                'is_verified': int(record['user']['verified']),
                'in_reply_to_user_id': record['in_reply_to_user_id'],
                'hashtags': record['entities']['hashtags'],
            }
            cleaned_data.append(flattened_record)
        except Exception as e:
            print(f"Raised error for record {i}: {e}")
        i += 1

cleaned_data = pd.DataFrame(cleaned_data)

cleaned_data[0:10].to_csv('processed-data/cleaned_tweets_mini.csv', index = False)

cleaned_data[0:100].to_csv('processed-data/cleaned_tweets_small.csv', index = False)

cleaned_data.to_csv('processed-data/cleaned_tweets_full.csv', index = False)
