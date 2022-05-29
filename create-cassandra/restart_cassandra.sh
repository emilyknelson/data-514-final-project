# Reconnecting to an existing Cassandra instance 

# Start docker daemon in background: 
dockerd &

# Run a CQL script 
docker run --rm --network cassandra_network -v "$(pwd)/setup.cql:/scripts/data.cql" -e CQLSH_HOST=cassandra_network -e CQLSH_PORT=9042 cassandra

# Open a CQL shell 
# After network, the first name is "cassandra" because it needs to connect to cassandra:latest locally
docker run --rm -it --network cassandra_network cassandra cqlsh cassandra_network 9042 --cqlversion='3.4.5'

# Load data 
/mnt/c/Users/eklin/Downloads/dsbulk-1.9.0/bin/dsbulk load -url processed_data/cleaned_tweets_mini.csv -k twitter_eurovision -t tweets