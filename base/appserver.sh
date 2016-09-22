#!/bin/bash

cd /home/app/webapp

/opt/wait-for-syslog.sh
exec chpst -u app bundle exec puma -v -C /etc/puma.rb \
  2>&1 |logger -t appserver
