#sh build.sh
envdir crowd.env docker run -d -e NEXUS_WEBAPP_CONTEXT_PATH=/ -e CROWD_APP_PASSWORD -name nexus -link crowd:crowd -p 8081:8081 -v /opt/sonatype-work griff/sonatype-nexus-crowd