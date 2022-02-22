FROM phusion/baseimage:focal-1.0.0

ENV RUBY_MAJOR "2.7"
ENV RUBY_VERSION "2.7.3"
ENV RUBYGEMS_VERSION "3.3.7"
ENV NODE_VERSION "10.24.1"
ENV BOWER_VERSION "1.8.2"

ENV APT_PACKAGES " \
  git imagemagick gcc g++ make patch binutils libc6-dev libjemalloc-dev \
  libffi-dev libssl-dev libyaml-dev zlib1g-dev libgmp-dev libxml2-dev \
  libxslt1-dev libpq-dev libreadline-dev libsqlite3-dev libmysqlclient-dev \
  tzdata yarn file google-chrome-stable \
"

ENV APT_REMOVE_PACKAGES "anacron cron openssh-server postfix"

COPY apt.conf /etc/apt/apt.conf.d/local
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
COPY yarn.list /etc/apt/sources.list.d
RUN curl -sS https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
COPY google-chrome.list /etc/apt/sources.list.d
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y --no-install-recommends $APT_PACKAGES
RUN apt-get remove --purge -y $APT_REMOVE_PACKAGES
RUN apt-get autoremove --purge -y

WORKDIR /tmp
RUN curl -o ruby.tgz \
    "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR}/ruby-${RUBY_VERSION}.tar.gz" && \
  tar -xzf ruby.tgz && \
  cd ruby-${RUBY_VERSION} && \
  ./configure --enable-shared --with-jemalloc --disable-install-doc && \
  make -j4 && \
  make install

ENV GEM_SPEC_CACHE "/tmp/gemspec"
RUN echo 'gem: --no-document' > $HOME/.gemrc
RUN gem update --system ${RUBYGEMS_VERSION}

RUN curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz \
  |tar -xz -C /usr --strip-components=1
RUN npm install bower@${BOWER_VERSION} -g

RUN rm /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN rm -r /etc/service/sshd /etc/service/cron

COPY wait-for-syslog.sh /opt/
COPY db_migrate.sh /etc/my_init.d/90_db_migrate.sh
COPY sidekiq.sh /etc/service/sidekiq/run
COPY appserver.sh /etc/service/appserver/run
COPY clockwork.sh /etc/service/clockwork/run

COPY puma.rb /etc/
COPY sidekiq.yml /etc/
COPY clockwork.rb /etc/

COPY rails-assets.sh /opt/
COPY custom-services.sh /opt/

RUN useradd -m app
COPY bundle_config /home/app/.bundle/config
RUN mkdir /home/app/webapp && chown app:app -R /home/app

RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt /var/lib/dpkg /usr/share/man /usr/share/doc
