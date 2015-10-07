#!/bin/bash

[ "$NEW_RELIC_LICENSE_KEY" == "" ] && sleep infinity

nrsysmond-config --set license_key=$NEW_RELIC_LICENSE_KEY
exec /usr/sbin/nrsysmond -f -c /etc/newrelic/nrsysmond.cfg
