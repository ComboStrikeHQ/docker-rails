FROM base-squashed

ENV RACK_ENV=production RAILS_ENV=production

ONBUILD CMD ["/sbin/my_init"]
ONBUILD EXPOSE 8080
ONBUILD WORKDIR /home/app/webapp

ONBUILD ADD Gemfile Gemfile.lock /home/app/webapp/
ONBUILD RUN chown app:app Gemfile Gemfile.lock && \
  chpst -u app bundle install --deployment --jobs 4 --without development test && \
  find vendor/bundle -name *.gem -delete

ONBUILD ADD . /home/app/webapp/
ONBUILD RUN mkdir -p db public/assets log tmp && chown -R app:app db public log tmp

ONBUILD RUN bash -ec \
  "if chpst -u app bundle show sprockets; then \
    touch .env; source .env; \
    chpst -u app bundle exec rake assets:precompile \
      SECRET_KEY_BASE=noop DATABASE_URL=postgres://noop ; \
    chpst -u app find public/assets -type f -exec 7z a -tgzip -mx=9 {}.gz {} \; ; \
  fi"
