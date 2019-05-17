FROM docker-rails-base-squashed

ENV RACK_ENV production
ENV RAILS_ENV production
ENV HOME /home/app
ENV RAILS_LOG_TO_STDOUT 1
ENV RAILS_SERVE_STATIC_FILES 1

CMD ["/sbin/my_init"]
EXPOSE 8080
WORKDIR /home/app/webapp

ONBUILD COPY Gemfile Gemfile.lock /home/app/webapp/
ONBUILD COPY vendor/ /home/app/webapp/vendor/
ONBUILD RUN chown -R app:app Gemfile Gemfile.lock vendor/ && \
  ($SKIP_BUNDLE_INSTALL || \
    (chpst -u app bundle install --local --deployment --jobs 4 --without development test && \
      find vendor/bundle -name *.gem -delete))

ONBUILD COPY . /home/app/webapp/
ONBUILD ARG BUGSNAG_API_KEY
ONBUILD ARG BUGSNAG_APP_VERSION
ONBUILD RUN mkdir -p db public/assets log tmp vendor && \
  chown -R app:app app db public log tmp vendor && chpst -u app /opt/rails-assets.sh && \
  /opt/custom-services.sh
