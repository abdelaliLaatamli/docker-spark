FROM openjdk:8


# Spark related variables. 
#available version 3.2.4, 3.3.2, 3.4.0, 3.4.1  if 3.2.4 then hadop 2.7 if 3.4.0 then hadop 3
ARG SPARK_VERSION=3.3.2  
ARG SPARK_BINARY_ARCHIVE_NAME=spark-${SPARK_VERSION}-bin-hadoop3
ARG SPARK_BINARY_DOWNLOAD_URL=https://dlcdn.apache.org/spark/spark-3.3.2/${SPARK_BINARY_ARCHIVE_NAME}.tgz



# Configure env variables for  Spark.
# Also configure PATH env variable to include binary folders of Java and Spark.

ENV SPARK_HOME  /usr/local/spark
ENV PATH        $JAVA_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH


# Download, uncompress and move all the required packages and libraries to their corresponding directories in /usr/local/ folder.
RUN apt-get -yqq update && \
    apt-get install -yqq vim screen tmux && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* 

RUN wget -qO - ${SPARK_BINARY_DOWNLOAD_URL} | tar -xz -C /usr/local/ 

RUN cd /usr/local/ && ln -s ${SPARK_BINARY_ARCHIVE_NAME} spark 

RUN ls /usr/local/spark/conf/ && sleep 10  
RUN cd /usr/local/ && cp spark/conf/log4j2.properties.template spark/conf/log4j2.properties && \
    sed -i -e s/WARN/ERROR/g spark/conf/log4j2.properties && \
    sed -i -e s/INFO/ERROR/g spark/conf/log4j2.properties


# We will be running our Spark jobs as `root` user.
USER root


# Working directory is set to the home folder of `root` user.
WORKDIR /root

# Expose ports for monitoring.
# SparkContext web UI on 4040 -- only available for the duration of the application.
# Spark master’s web UI on 8080.
# Spark worker web UI on 8081.
EXPOSE 4040 8080 8081


CMD ["/bin/bash"]