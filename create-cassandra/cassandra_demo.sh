# Cassandra demo
# Everything for docker needs to be run as root! 

#Start docker daemon in background: 
dockerd &

# List all docker images 
docker image ls

# Create cassandra network 
docker network create cassandra_network 

# Launch a cassandra instance that is connected to this cassandra network
# args: 
# --rm remove the image after you exit 
# -d run the container in the background 
# --name image name 
# --hostname ?? 
# --network the name of the network you just created above 
# final argument is telling you the docker image to launch. Needs to be "cassandra". 
docker run --rm -d --name cassandra_instance --hostname cassandra_network --network cassandra_network cassandra

# Run a CQL script 
docker run --rm --network cassandra_network -v "$(pwd)/setup.cql:/scripts/data.cql" -e CQLSH_HOST=cassandra_network -e CQLSH_PORT=9042 cassandra

# Copy the tweets file 
docker cp /mnt/c/Users/eklin/Downloads/data-514/data-514-final-project/processed-data/cleaned_tweets_full.csv cassandra_instance:cleaned_tweets_full.csv

# Verify that the file is there by launching a bash shell on the container 
docker exec -it cassandra_instance /bin/bash

# Create keyspace and table 
SELECT * FROM system_schema.keyspaces;
CREATE KEYSPACE IF NOT EXISTS twitter_eurovision WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };
SELECT * FROM system_schema.keyspaces;

SELECT keyspace_name, table_name FROM system_schema.tables WHERE keyspace_name = 'twitter_eurovision';
-- Create a table
CREATE TABLE IF NOT EXISTS twitter_eurovision.tweets (
	created_at text,
	tweet_id int,
	user_id int,
	is_verified int,
	tweet text,
	screen_name text,
	in_reply_to_user_id int,
	hashtags text,
	PRIMARY KEY (user_id)
);

SELECT keyspace_name, table_name FROM system_schema.tables WHERE keyspace_name = 'twitter_eurovision';

# Import data 
COPY twitter_eurovision.tweets (created_at,tweet_id,user_id,tweet,screen_name,is_verified,in_reply_to_user_id,hashtags) 
FROM 'cleaned_tweets_full.csv' 
WITH HEADER = TRUE;