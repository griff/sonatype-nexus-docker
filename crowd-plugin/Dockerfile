FROM griff/sonatype-nexus
MAINTAINER Brian Olsen "brian@maven-group.org"

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y unzip
USER nexus
RUN mkdir -p /opt/sonatype-work/nexus/conf /opt/sonatype-work/nexus/plugin-repository
RUN wget --no-verbose -O /tmp/nexus-crowd-plugin.zip https://github.com/PatrickRoumanoff/nexus-crowd-plugin/wiki/nexus-crowd-plugin-2.0.7-bundle.zip
RUN unzip /tmp/nexus-crowd-plugin.zip -d /opt/sonatype-work/nexus/plugin-repository 
USER root
ADD start.sh /opt/start.sh
RUN chmod a+x /opt/start.sh
RUN chown -R nexus:nexus /opt/sonatype-work
USER nexus
ENV CROWD_APP_NAME nexus
ENV CROWD_LINK_ENV CROWD_PORT
ENV CROWD_SERVER_PATH /crowd/
ENV CROWD_SERVER_PROTO http
CMD ["/opt/start.sh"]




