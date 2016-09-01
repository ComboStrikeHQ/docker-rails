#!/bin/bash -e

if ! bundle show sprockets; then
  echo "No sprockets found - not compiling any assets."
  exit 0
fi

if bundle show pg; then
  export DATABASE_URL="postgres://noop"
elif bundle show mysql2; then
  export DATABASE_URL="mysql2://noop"
elif bundle show sqlite3; then
  export DATABASE_URL="sqlite3://noop"
else
  echo "Cannot find database gem - asset compilation might fail."
fi

if [ -e .env ]; then
  source .env
fi

bundle exec rake assets:precompile SECRET_KEY_BASE=noop
