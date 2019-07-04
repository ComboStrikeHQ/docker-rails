FROM docker-rails-base-squashed

ENV RACK_ENV=production RAILS_ENV=production RAILS_LOG_TO_STDOUT=1 \
  RAILS_SERVE_STATIC_FILES=1

# Workaround for $HOME being ignored in phusion/baseimage.
# See: https://github.com/phusion/baseimage-docker/issues/119#issuecomment-287970522
RUN echo /home/app > /etc/container_environment/HOME

CMD ["/sbin/my_init"]
EXPOSE 8080
WORKDIR /home/app/webapp

ONBUILD COPY Gemfile Gemfile.lock /home/app/webapp/
ONBUILD COPY . /home/app/webapp/
ONBUILD RUN chown -R app:app .
ONBUILD RUN chpst -u app bundle install --deployment --jobs 4 --without development test
ONBUILD RUN find vendor -name *.gem -delete

ONBUILD ARG BUGSNAG_API_KEY
ONBUILD ARG BUGSNAG_APP_VERSION
ONBUILD RUN chpst -u app mkdir -p db public/assets log tmp vendor
ONBUILD RUN chpst -u app /opt/rails-assets.sh
ONBUILD RUN /opt/custom-services.sh
