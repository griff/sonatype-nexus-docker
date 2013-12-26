FROM griff/oracle-jdk7
MAINTAINER Brian Olsen "brian@maven-group.org"

RUN mkdir -p /opt/sonatype-nexus /opt/sonatype-work
RUN wget -O /tmp/nexus-latest-bundle.tar.gz http://www.sonatype.org/downloads/nexus-2.6.4-bundle.tar.gz
RUN tar xzvf /tmp/nexus-latest-bundle.tar.gz -C /opt/sonatype-nexus --strip-components=1
EXPOSE 8081
RUN useradd --user-group --system --home-dir /opt/sonatype-nexus nexus
RUN chown -R nexus:nexus /opt/sonatype-work /opt/sonatype-nexus
USER nexus
#VOLUME /opt/sonatype-work
ENV NEXUS_WEBAPP_CONTEXT_PATH /nexus
ADD start.sh /opt/start_nexus.sh

CMD ["/opt/start_nexus.sh"]






















