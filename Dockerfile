FROM ubuntu:14.04
MAINTAINER Marcello_deSales@intuit.com

RUN apt-get -qq update && apt-get -qq install openjdk-7-jdk maven wget

RUN wget -O /tmp/nexus-latest-bundle.tar.gz http://download.sonatype.com/nexus/oss/nexus-latest-bundle.tar.gz

RUN mkdir -p /opt/sonatype-nexus /opt/sonatype-work /opt/sonatype-work/nexus && \
    tar -zxvf /tmp/nexus-latest-bundle.tar.gz -C /opt/sonatype-nexus --strip-components=1 && \
    rm -f /tmp/nexus-latest-bundle.tar.gz && \
    useradd --user-group --system --home-dir /opt/sonatype-nexus nexus && \
    chown -R nexus:nexus /opt/sonatype-work /opt/sonatype-nexus /opt/sonatype-work/nexus

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

#USER nexus
ENV RUN_AS_USER root
CMD ["/opt/sonatype-nexus/bin/nexus","console"]

VOLUME /opt/sonatype-work
EXPOSE 8081
