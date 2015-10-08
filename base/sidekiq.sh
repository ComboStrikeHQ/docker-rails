#!/bin/bash

SIDEKIQ_THREADS=${SIDEKIQ_THREADS:-16}

cd /home/app/webapp

bundle show sidekiq || sleep infinity

SIDEKIQ_CONFIG="/home/app/webapp/config/sidekiq.yml"
if [ ! -f $SIDEKIQ_CONFIG ]; then
  SIDEKIQ_CONFIG="/etc/sidekiq.yml"
fi

exec chpst -u app bundle exec sidekiq -t 5 -c $SIDEKIQ_THREADS -C $SIDEKIQ_CONFIG \
  |logger -s -t sidekiq
