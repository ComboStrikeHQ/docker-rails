#!/bin/bash

cd /home/app/webapp

exec chpst -u app bundle exec puma -C /etc/puma.rb \
  2>&1 |logger -t appserver
