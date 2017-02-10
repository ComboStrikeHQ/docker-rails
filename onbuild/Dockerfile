FROM docker-rails-base-squashed

ENV RACK_ENV=production RAILS_ENV=production HOME=/home/app \
  RAILS_LOG_TO_STDOUT=1 RAILS_SERVE_STATIC_FILES=1
CMD ["/sbin/my_init"]
EXPOSE 8080
WORKDIR /home/app/webapp

ONBUILD ARG BUNDLE_GITHUB__COM
ONBUILD ENV BUNDLE_GITHUB__COM ${BUNDLE_GITHUB__COM:-}

ONBUILD COPY Gemfile Gemfile.lock /home/app/webapp/
ONBUILD COPY vendor/ /home/app/webapp/vendor/
ONBUILD RUN chown -R app:app Gemfile Gemfile.lock vendor/ && \
  chpst -u app bundle install --deployment --jobs 4 --without development test && \
  find vendor/bundle -name *.gem -delete

ONBUILD COPY . /home/app/webapp/
ONBUILD RUN mkdir -p db public/assets log tmp vendor && \
  chown -R app:app app db public log tmp vendor && chpst -u app /opt/rails-assets.sh
