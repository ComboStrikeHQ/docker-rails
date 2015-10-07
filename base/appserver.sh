#!/bin/bash

cd /home/app/webapp

exec chpst -u app bundle exec puma -C /etc/puma.rb \
  |logger -s -t appserver
