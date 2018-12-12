FROM openjdk:8-jre

ENV VERSION_HADOOP=3.1.1
ENV VERSION_POSTGRES_JDBC=42.2.5

ENV HADOOP_HOME=/home/hadoop/hadoop-${VERSION_HADOOP}
ENV HIVE_HOME=/home/hadoop/apache-hive-${VERSION_HADOOP}-bin

WORKDIR /home/hadoop
RUN useradd -d /home/hadoop hadoop && chown -R hadoop: ~hadoop

RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

USER hadoop

RUN (wget -q http://apache.mirror.iweb.ca/hive/hive-${VERSION_HADOOP}/apache-hive-${VERSION_HADOOP}-bin.tar.gz && tar xzvf apache-hive-${VERSION_HADOOP}-bin.tar.gz && rm apache-hive-3.1.1-bin.tar.gz) & \
 (wget -q http://apache.mirror.iweb.ca/hadoop/common/hadoop-${VERSION_HADOOP}/hadoop-${VERSION_HADOOP}.tar.gz && tar xzvf hadoop-3.1.1.tar.gz && rm hadoop-${VERSION_HADOOP}.tar.gz) && \
 wget -q https://jdbc.postgresql.org/download/postgresql-${VERSION_POSTGRES_JDBC}.jar -O $HIVE_HOME/lib/postgresql-jdbc.jar

RUN mkdir /tmp/hive && chmod 733 /tmp/hive

ENTRYPOINT [ "$HIVE_HOME/bin/hiveserver2" ]
