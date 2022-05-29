#Cassandra startup notes: 
# Everything for docker needs to be run as root! 

#Start docker daemon in background: 
dockerd &

# List all docker images 
docker image ls

# Pull latest cassandra image 
docker pull cassandra:latest

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

# Open a CQL shell 
# After network, the first name is "cassandra" because it needs to connect to cassandra:latest locally
docker run --rm -it --network cassandra_network cassandra cqlsh cassandra_network 9042 --cqlversion='3.4.5'

# All of these commands are working to here! 