FROM docker-rails-base-squashed

ENV RACK_ENV=production RAILS_ENV=production HOME=/home/app
CMD ["/sbin/my_init"]
EXPOSE 8080
WORKDIR /home/app/webapp

ONBUILD COPY Gemfile Gemfile.lock /home/app/webapp/
ONBUILD RUN chown app:app Gemfile Gemfile.lock && \
  chpst -u app bundle install --deployment --jobs 4 --without development test && \
  find vendor/bundle -name *.gem -delete

ONBUILD COPY . /home/app/webapp/
ONBUILD RUN mkdir -p db public/assets log tmp && chown -R app:app db public log tmp

ONBUILD RUN bash -ec \
  "if chpst -u app bundle show sprockets; then \
    touch .env; source .env; \
    chpst -u app bundle exec rake assets:precompile \
      SECRET_KEY_BASE=noop DATABASE_URL=postgres://noop ; \
  fi"
