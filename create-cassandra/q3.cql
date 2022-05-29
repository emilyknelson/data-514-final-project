
# Question: Which user has posted the most tweets? 
# In Cassandra, you can only group by the primary key. 
# Because the database schema I created uses "created_at" as the primary key, 
# I was not able to run this query. 

# I recreated my table schema with "user_id" as the primary key. 
# There have to be other solutions to this problem though! 

# Q1
SELECT user_id, COUNT(*) FROM twitter_eurovision.tweets GROUP BY user_id;


# Q2
# Question: How many tweets are associated with each hashtag? (For tweets with multiple hashtags, add it for all them)
# For this question, I needed to do some parsing with python. 

SELECT hashtags FROM twitter_eurovision.tweets;