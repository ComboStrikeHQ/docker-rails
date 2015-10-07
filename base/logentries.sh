#!/bin/bash

# keep default logging if we don't have a token
[ "$LOGENTRIES_API_TOKEN" == "" ] && exit 0

sed "s/LOGENTRIES_API_TOKEN/$LOGENTRIES_API_TOKEN/g" \
  < /etc/syslog-ng.logentries.conf \
  > /etc/syslog-ng/syslog-ng.conf
