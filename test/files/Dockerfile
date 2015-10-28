FROM docker-rails-onbuild

# wait for postgres db in docker-compose to fully boot up
COPY wait_for_postgres.sh /etc/my_init.d/00_wait_for_postgres.sh
