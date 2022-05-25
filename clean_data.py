import json
import pandas as pd

f = open('raw-data/Eurovision3.json', 'r')
records = f.readlines()

breakpoint()
cleaned_data = []
i = 0
for record in records:
    print(f"Processing record {i}")
    record = record.strip()
    if record: # Many of the lines in the file are empty. Ignore these.
        record = json.loads(record)

        flattened_record = {
            'created_at': record['created_at'],
            'tweet_id': record['id'],
            'user_id': record['user']['id'],
            'tweet': record['text'],
            'screen_name': record['user']['screen_name'],
            'in_reply_to_user_id': record['in_reply_to_user_id'],
            'hashtags': record['entities']['hashtags'],
        }
        cleaned_data.append(flattened_record)
        i += 1

cleaned_data = pd.DataFrame(cleaned_data)

cleaned_data[0:10].to_csv('processed-data/cleaned_tweets_mini.csv')

cleaned_data[0:100].to_csv('processed-data/cleaned_tweets_small.csv')

cleaned_data.to_csv('processed-data/cleaned_tweets_full.csv')
