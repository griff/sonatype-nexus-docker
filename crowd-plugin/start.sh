#!/bin/bash
set -o errexit

parse_url()
{
  unset errexit
  local prefix=DOCKER_LINK
  [ -n "$2" ] && prefix=$2
  # extract the protocol
  local proto="`echo $1 | grep '://' | sed -e's,^\(.*\)://.*,\1,g'`"
  # remove the protocol
  local url=`echo $1 | sed -e s,$proto://,,g`

  # extract the host -- updated
  local hostport=`echo $url | cut -d/ -f1`
  local port=`echo $hostport | grep : | cut -d: -f2`
  if [ -n "$port" ]; then
    local host=`echo $hostport | grep : | cut -d: -f1`
  else
    local host=$hostport
  fi

  [ -n "$proto" ] && eval "export ${prefix}_PROTO=\"$proto\""
  [ -n "$host" ] && eval "export ${prefix}_ADDR=\"$host\""
  [ -n "$port" ] && eval "export ${prefix}_PORT=\"$port\""
	set -o errexit
}
if [ -z "$CROWD_SERVER_URL" ]; then
  parse_url "$(eval "echo \$$CROWD_LINK_ENV")"
  export CROWD_SERVER_URL="${CROWD_SERVER_PROTO}://${DOCKER_LINK_ADDR}:${DOCKER_LINK_PORT}${CROWD_SERVER_PATH}"
fi

cat <<END > /opt/sonatype-work/nexus/conf/crowd-plugin.xml
<?xml version="1.0" encoding="UTF-8"?>
<crowdConfiguration>
  <crowdServerUrl>${CROWD_SERVER_URL}</crowdServerUrl>
  <applicationName>${CROWD_APP_NAME}</applicationName>
  <applicationPassword>${CROWD_APP_PASSWORD}</applicationPassword>
</crowdConfiguration>
END

exec "/opt/start_nexus.sh"