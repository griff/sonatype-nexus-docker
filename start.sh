#!/bin/bash

cd /opt/sonatype-nexus
mv conf/nexus.properties conf/nexus.properties.old
awk -v newval="$NEXUS_WEBAPP_CONTEXT_PATH" -v pname="nexus-webapp-context-path" 'BEGIN{ FS="=";OFS="=" } {if($1==pname) $2=newval; print $0;}' conf/nexus.properties.old > conf/nexus.properties

exec "/opt/sonatype-nexus/bin/nexus" "console"