SELECT * FROM system_schema.keyspaces;
CREATE KEYSPACE IF NOT EXISTS twitter_eurovision WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };
SELECT * FROM system_schema.keyspaces;

SELECT * FROM system_schema.tables WHERE keyspace_name = 'twitter_eurovision';
-- Create a table
CREATE TABLE IF NOT EXISTS twitter_eurovision.tweets (
	created_at text PRIMARY KEY,
	tweet_id int,
	user_id int,
	tweet text,
	screen_name text,
	in_reply_to_user_id int,
	hashtags text
);
CREATE INDEX ON twitter_eurovision.tweets (user_id);

SELECT * FROM system_schema.tables WHERE keyspace_name = 'twitter_eurovision';