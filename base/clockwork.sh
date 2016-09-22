#!/bin/bash

cd /home/app/webapp

bundle show clockwork || sleep infinity

/opt/wait-for-syslog.sh
exec chpst -u app bundle exec rails runner /etc/clockwork.rb \
  2>&1 |logger -t clockwork
