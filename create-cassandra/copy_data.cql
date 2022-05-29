COPY twitter_eurovision.tweets (created_at, tweet_id, user_id, tweet, screen_name, in_reply_to_user_id, hashtags) 
FROM 'cleaned_tweets_mini.csv' 
WITH HEADER = TRUE;