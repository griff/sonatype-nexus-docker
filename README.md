sonatype-nexus-docker
=====================

Docker version of Sonatype Nexus

Usage
------
```
docker run -p 8081:8081 -name nexus griff/sonatype-nexus
```
And then point your browser at http://localhost:8081/nexus/

Or with explicitly specified volume target:
```
mkdir -p /devdata/nexus
docker run -v /devdata/nexus:/opt/sonatype-work -p 8081:8081 -name nexus griff/sonatype-nexus
```

Options
--------
NEXUS_WEBAPP_CONTEXT_PATH
The prefix the webapp uses when starting the server. Defaults to /nexus.
Setting it to / will cause the url to use in your browser to be http://localhost:8081/

