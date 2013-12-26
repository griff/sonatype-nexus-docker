docker build -rm -t griff/sonatype-nexus .
docker tag griff/sonatype-nexus griff/sonatype-nexus:2.6.4
docker build -rm -t griff/sonatype-nexus-crowd crowd-plugin
docker tag griff/sonatype-nexus-crowd griff/sonatype-nexus-crowd:2.6.4-2.0.7
