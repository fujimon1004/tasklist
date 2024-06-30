FROM openjdk:17-jdk-slim

ARG MAVEN_VERSION=3.9.8
ARG USER_HOME_DIR="/root"
ARG SHA512=7d171def9b85846bf757a2cec94b7529371068a0670df14682447224e57983528e97a6d1b850327e4ca02b139abaab7fcb93c4315119e6f0ffb3f0cbc0d0b9a2
ARG BASE_URL=https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN apt-get update && \
    apt-get install -y curl && \
    mkdir -p /usr/share/maven /usr/share/maven/ref && \
    curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    echo "${SHA512}  /tmp/apache-maven.tar.gz" | sha512sum -c - && \
    tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
    rm -f /tmp/apache-maven.tar.gz && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

COPY . /app
WORKDIR /app

RUN mvn dependency:go-offline

CMD ["mvn", "clean", "package"]