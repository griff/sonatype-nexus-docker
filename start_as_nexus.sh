#!/bin/sh
set -o errexit
chown nexus:nexus /opt/sonatype-work
if [ -z "$(ls -A /opt/sonatype-work)" ]; then
  cp -R --preserve=all /opt/sonatype-work-template /opt/sonatype-work
fi

cd /opt/sonatype-nexus
mv conf/nexus.properties conf/nexus.properties.old
awk -v newval="$NEXUS_WEBAPP_CONTEXT_PATH" -v pname="nexus-webapp-context-path" 'BEGIN{ FS="=";OFS="=" } {if($1==pname) $2=newval; print $0;}' conf/nexus.properties.old > conf/nexus.properties

su -c '/opt/start.sh "$@"' - nexus
