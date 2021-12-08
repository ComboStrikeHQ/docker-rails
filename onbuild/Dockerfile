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
ONBUILD RUN gem install bundler -v "$(grep -A 1 'BUNDLED WITH' Gemfile.lock | grep -Po '[\d.]+')" --force
ONBUILD COPY . /home/app/webapp/
ONBUILD RUN chown -R app:app .

ONBUILD USER app

ONBUILD RUN bundle install --jobs 4
ONBUILD ARG BUGSNAG_API_KEY
ONBUILD ARG BUGSNAG_APP_VERSION
ONBUILD RUN mkdir -p db public/assets log tmp vendor
ONBUILD RUN /opt/rails-assets.sh

ONBUILD USER root

ONBUILD RUN find vendor -name *.gem -delete
ONBUILD RUN /opt/custom-services.sh

