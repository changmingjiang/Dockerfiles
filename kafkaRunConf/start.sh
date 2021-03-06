#!/usr/bin/env bash
LocaleIp=`ip addr show en0|grep 'inet '|awk '{print $2}'|awk -F/ '{print $1}'`

mkdir -p `pwd`/9091/logs
docker run --restart=always -d --name kafka-9091 \
	--hostname=$LocaleIp \
	--expose 9091 -p 9091:9091 \
	-v `pwd`/9091/logs:/opt/kafka/logs \
	\
	-e KAFKA_LISTENERS=PLAINTEXT://:9091 \
	-e KAFKA_ZOOKEEPER_CONNECT=$LocaleIp:2181,$LocaleIp:2182,$LocaleIp:2183 \
	-e KAFKA_BROKER_ID=1 \
	-e BOOTSTRAP_SERVERS=$LocaleIp:9091,$LocaleIp:9092,$LocaleIp:9093 \
	\
	-e KAFKA_NUM_PARTITIONS=1 \
	-e KAFKA_INTERNAL_TOPIC_NUM=2 \
	\
	changmingjiang/kafka:latest

mkdir -p `pwd`/9092/logs
docker run --restart=always -d --name kafka-9092 \
	--hostname=$LocaleIp \
	--expose 9092 -p 9092:9092 \
	-v `pwd`/9092/logs:/opt/kafka/logs \
	\
	-e KAFKA_LISTENERS=PLAINTEXT://:9092 \
	-e KAFKA_ZOOKEEPER_CONNECT=$LocaleIp:2181,$LocaleIp:2182,$LocaleIp:2183 \
	-e KAFKA_BROKER_ID=2 \
	-e BOOTSTRAP_SERVERS=$LocaleIp:9091,$LocaleIp:9092,$LocaleIp:9093 \
	\
	-e KAFKA_NUM_PARTITIONS=1 \
	-e KAFKA_INTERNAL_TOPIC_NUM=2 \
	\
	changmingjiang/kafka:latest

mkdir -p `pwd`/9093/logs
docker run --restart=always -d --name kafka-9093 \
	--hostname=$LocaleIp \
	--expose 9093 -p 9093:9093 \
	-v `pwd`/9093/logs:/opt/kafka/logs \
	\
	-e KAFKA_LISTENERS=PLAINTEXT://:9093 \
	-e KAFKA_ZOOKEEPER_CONNECT=$LocaleIp:2181,$LocaleIp:2182,$LocaleIp:2183 \
	-e KAFKA_BROKER_ID=3 \
	-e BOOTSTRAP_SERVERS=$LocaleIp:9091,$LocaleIp:9092,$LocaleIp:9093 \
	\
	-e KAFKA_NUM_PARTITIONS=1 \
	-e KAFKA_INTERNAL_TOPIC_NUM=2 \
	\
	changmingjiang/kafka:latest
