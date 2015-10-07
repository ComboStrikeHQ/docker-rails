#!/bin/bash

SIDEKIQ_THREADS=${SIDEKIQ_THREADS:-16}

cd /home/app/webapp

bundle show sidekiq || sleep infinity

exec chpst -u app bundle exec sidekiq \
  -t 5 -c $SIDEKIQ_THREADS -q default -q mailers \
  |logger -s -t sidekiq
