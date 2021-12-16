#!/bin/bash -xe

function testapp_run() {
  if ! docker-compose run app "$@"; then
    echo "Test '$@' failed!"
    exit 1
  fi
}

function check_logs {
  local n=1
  local max=10
  local delay=15
  while true; do
    docker-compose logs app | grep "$1" | grep "$2" && break || {
      if [[ $n -lt $max ]]; then
        ((n++))
        echo "Check failed. Attempt $n/$max:"
        sleep $delay;
      else
        echo "Couldn't find $1.*$2 in the logs after $n attempts."
        exit 1
      fi
    }
  done
}

cd test
rm -rf testapp

# Set up testing rails app
gem install bundler
gem install rails -v '<7'
rails new testapp -d postgresql -m template.rb --skip-bundle
cp -r files/* testapp
chmod 644 testapp/config/master.key
(
  cd testapp
  bundle config set cache_all true
  bundle package
  rails webpacker:install
)

# Build container
docker-compose kill || true
docker-compose rm -f
docker-compose build
docker-compose up -d app redis postgres

# Check that app server boots correctly, ENV variables are exposed and sidekiq works properly
RESULT=$(docker-compose run curl -s --retry 60 --retry-delay 1 --retry-connrefused http://app:8080/)
[[ "$RESULT" =~ 'ok' ]] || exit 1

# Check that static file serving is enabled
docker-compose run curl -v \
                        -4 \
                        --retry 60 \
                        --retry-delay 1 \
                        --retry-connrefused http://app:8080/robots.txt \
                   | grep documentation || exit 1

# Check that logs are sent to STDOUT
check_logs appserver "Completed 200 OK" || exit 1
check_logs sidekiq "ClockworkTestWorker" || exit 1
check_logs clockwork "Triggering" || exit 1
check_logs test_service "Running" || exit 1

# Clean up
docker-compose stop

# Check that imagemagick is present
testapp_run which convert

# Check that ruby uses jemalloc
testapp_run bash -c "ldd /usr/local/bin/ruby |grep jemalloc"

# Check that openssl/readline is working in ruby
testapp_run ruby -r readline -e puts
testapp_run ruby -r openssl -e puts

# Check that nodejs, npm and bower are present
RESULT=$(testapp_run node -p '1+1')
[[ "$RESULT" == "2"* ]] || exit 1
testapp_run npm -v
testapp_run bower -v

# Check that asset gzipping works
FILE="/home/app/webapp/public/packs/js/application-*.js"
testapp_run bash -ec "gzip -dc < $FILE.gz | diff - $FILE"

echo "Tests OK"
