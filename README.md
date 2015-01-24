sonatype-nexus-docker
=====================

Docker version of Sonatype Nexus

Usage
------
```
docker run -p 8081:8081 --name nexus griff/sonatype-nexus
```
And then point your browser at http://localhost:8081/nexus/

Or with explicitly specified volume target:
```
mkdir -p /devdata/nexus
docker run -v /devdata/nexus:/opt/sonatype-work -p 8081:8081 --name nexus griff/sonatype-nexus
```

Options / Environment variables
--------
The image supports an option NEXUS_WEBAPP_CONTEXT_PATH which you can set as an
environment variable when running the image that sets the URL prefix the
webapp uses when starting the server. Defaults to /nexus. 

An example usage with the option:
```
docker run -e NEXUS_WEBAPP_CONTEXT_PATH=/ griff/sonatype-nexus
```
Which changes the URL to http://localhost:8081/
