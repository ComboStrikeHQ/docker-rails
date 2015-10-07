#!/bin/bash

cd /home/app/webapp

if bundle show rails_migrate_mutex; then
  chpst -u app bundle exec rake db:migrate:mutex
fi
