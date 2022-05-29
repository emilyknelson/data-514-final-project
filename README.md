# data-514-final-project
This code was written by Emily Linebarger to implement a local Cassandra database for DATA 514, Spring 2022

## Data 
The dataset used was a public Kaggle dataset, representing twitter data from the 2018 Eurovision final. 
The data are available for download here: https://www.kaggle.com/datasets/patrickjoan/twitter-data-from-2018-eurovision-final?select=Eurovision3.json

The file "Eurovision3.json" was the only file used. 

Inside the repository, the file data.tar.gz includes both the raw and the processed data used for the project. 
The data was cleaned with the python script "create_cassandra/clean_data.py". 

## Code 
There are two main folders, "create_cassandra" and "query_cassandra". 

Inside the "create_cassandra" folder, there are the following scripts: 

1. cassandra_demo.sh: Commands used to produce demo video for final project
2. cassandra_notes.sh: Initial commands used to set up Cassandra database, and notes on getting it running. 
3. clean_data.py: Used to clean raw twitter JSON into three final CSVs for upload into database. 
4. copy_data.cql: (OUT OF DATE - Code for final project is in cassandra_demo.sh) Command used to copy a CSV file into cassandra. 
5. create-keyspace-and-table.cql: (OUT OF DATE - Code for final project is in cassandra_demo.sh) Code to create a single keyspace and table
6. insert-single-tweet.cql: Demo to insert a single tweet into Cassandra database 
7. restart_cassandra.sh: (OUT OF DATE - Code for final project is in cassandra_demo.sh) Commands to restart a cassandra instance after it had been shut down. 
8. sample_tweet.txt: Used with insert-single-tweet.cql. A single tweet to insert into the database. 

Inside the "query_cassandra" folder, there are the following scripts: 

1. q1.py: Python wrapper around Cassandra code that returns results for the query "Which user had the most tweets?"
2. q2.py: "" Returns results for the query "How many tweets are associated with each hashtag?"
3. q3.py: "" Returns results for the query "For each verified user, what is the percentage of each type of tweet?"

## License
This code is published with a MIT License. 