CREATE KEYSPACE IF NOT EXISTS twitter WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };

-- Create a table
CREATE TABLE IF NOT EXISTS twitter.eurovision_tweets (
	created_at text PRIMARY KEY,
	tweet_id int,
	user_id int,
	tweet text,
	screen_name text,
	in_reply_to_user_id int,
	hashtags text
);
CREATE INDEX ON twitter.eurovision_tweets (user_id);

