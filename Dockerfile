FROM debezium/connect:1.0
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc \
    KAFKA_CONNECT_ES_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-elasticsearch

ARG POSTGRES_VERSION=42.2.8 # 42.3.3 is newest
ARG KAFKA_JDBC_VERSION=10.2.5 # replacing 5.3.2
ARG KAFKA_ELASTICSEARCH_VERSION=11.1.4 # replacing 5.3.2

# Deploy PostgreSQL JDBC Driver
RUN cd /kafka/libs && curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar

COPY target/kafka-connect-elasticsearch-11.1.4-package/share/java/kafka-connect-elasticsearch $KAFKA_CONNECT_ES_DIR
