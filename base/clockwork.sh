#!/bin/bash

cd /home/app/webapp

bundle show clockwork || sleep infinity

exec chpst -u app bundle exec rails runner /etc/clockwork.rb \
  2>&1 |logger -t clockwork
