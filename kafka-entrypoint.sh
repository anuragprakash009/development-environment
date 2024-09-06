#!/bin/bash

# Simply wait until original kafka container and zookeeper are started.
sleep 20

# Parse string of kafka topics into an array
# https://stackoverflow.com/a/10586169/4587961
#kafkatopicsArrayString="$KAFKA_TOPICS"
#IFS=' ' read -r -a kafkaTopicsArray <<< "$kafkatopicsArrayString"
kafkatopicsArrayString="$KAFKA_TOPICS"
echo "received kafka topics to initialize:
$kafkatopicsArrayString"
kafkaTopicsArray=($kafkatopicsArrayString)
# A separate variable for zookeeper hosts.
echo "zookeeper broker $KAFKA_ZOOKEEPER_CONNECT"
zookeeperHostsValue=$KAFKA_ZOOKEEPER_CONNECT

# Create kafka topic for each topic item from split array of topics.
for newTopic in "${kafkaTopicsArray[@]}"; do
  echo "initializing $newTopic"
  # https://kafka.apache.org/quickstart
  kafka-topics --create --bootstrap-server localhost:9092 --topic "$newTopic" --partitions 1 --replication-factor 1
  echo "done"
done