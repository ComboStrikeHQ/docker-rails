#!/bin/bash

cd /home/app/webapp

sv start syslog-ng
exec chpst -u app bundle exec puma -v -C /etc/puma.rb \
  2>&1 |logger -t appserver
