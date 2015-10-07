FROM phusion/baseimage:0.9.17

ENV RUBY_MAJOR "2.2"
ENV RUBY_VERSION "2.2.3"

ENV APT_PACKAGES=" \
  git imagemagick nodejs \
  newrelic-sysmond \
  gcc g++ make patch binutils libc6-dev \
  libjemalloc-dev libffi-dev libssl-dev libyaml-dev zlib1g-dev libgmp-dev \
  libxml2-dev libxslt1-dev libpq-dev libreadline-dev libsqlite3-dev \
"

RUN echo "deb http://apt.newrelic.com/debian/ newrelic non-free" \
  > /etc/apt/sources.list.d/newrelic.list
RUN curl https://download.newrelic.com/548C16BF.gpg |apt-key add -

COPY apt.conf /etc/apt/apt.conf.d/local
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y $APT_PACKAGES
RUN apt-get autoremove --purge -y

RUN ln -s /usr/bin/nodejs /usr/bin/node

WORKDIR /tmp
RUN curl -o ruby.tgz \
    "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR}/ruby-${RUBY_VERSION}.tar.gz" && \
  tar -xzf ruby.tgz && \
  cd ruby-${RUBY_VERSION} && \
  ./configure --with-jemalloc --disable-install-doc && \
  make -j4 && \
  make install

ENV GEM_SPEC_CACHE "/tmp/gemspec"
RUN echo 'gem: --no-document' > $HOME/.gemrc
RUN gem update --system
RUN gem install bundler

RUN rm -r /etc/service/sshd /etc/service/syslog-forwarder /etc/service/cron

COPY logentries.sh /etc/my_init.d/10_logentries.sh
COPY db_migrate.sh /etc/my_init.d/90_db_migrate.sh
COPY newrelic_sysmon.sh /etc/service/newrelic_sysmon/run
COPY sidekiq.sh /etc/service/sidekiq/run
COPY appserver.sh /etc/service/appserver/run

COPY syslog-ng.logentries.conf /etc/
COPY puma.rb /etc/puma.rb

RUN useradd -m app
RUN mkdir /home/app/webapp && chown app:app -R /home/app

#RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt /var/lib/dpkg /usr/share/man /usr/share/doc
