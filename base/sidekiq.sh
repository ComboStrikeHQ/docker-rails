#!/bin/bash

SIDEKIQ_THREADS=${SIDEKIQ_THREADS:-16}

cd /home/app/webapp

bundle show sidekiq || sleep infinity

SIDEKIQ_CONFIG="/home/app/webapp/config/sidekiq.yml"
if [ ! -f $SIDEKIQ_CONFIG ]; then
  SIDEKIQ_CONFIG="/etc/sidekiq.yml"
fi

/opt/wait-for-syslog.sh
exec chpst -u app bundle exec sidekiq -e $RAILS_ENV -t 5 -c $SIDEKIQ_THREADS -C $SIDEKIQ_CONFIG \
  2>&1 |logger -t sidekiq
