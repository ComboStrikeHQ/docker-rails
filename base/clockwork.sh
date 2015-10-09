#!/bin/bash

cd /home/app/webapp

bundle show clockwork || sleep infinity

exec chpst -u app bundle exec rails runner 'load "config/clockwork.rb"; Clockwork::run' \
  |logger -s -t clockwork
