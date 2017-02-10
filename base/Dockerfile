FROM phusion/baseimage:0.9.19

ENV RUBY_MAJOR "2.3"
ENV RUBY_VERSION "2.3.1"
ENV RUBYGEMS_VERSION "2.6.10"
ENV BUNDLER_VERSION "1.14.3"
ENV NODE_VERSION "6.9.4"
ENV BOWER_VERSION "1.8.0"

ENV APT_PACKAGES " \
  git imagemagick \
  gcc g++ make patch binutils libc6-dev \
  libjemalloc-dev libffi-dev libssl-dev libyaml-dev zlib1g-dev libgmp-dev \
  libxml2-dev libxslt1-dev libpq-dev libreadline-dev libsqlite3-dev libmysqlclient-dev \
"

ENV APT_REMOVE_PACKAGES "anacron cron openssh-server postfix"

COPY apt.conf /etc/apt/apt.conf.d/local
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y $APT_PACKAGES
RUN apt-get remove --purge -y $APT_REMOVE_PACKAGES
RUN apt-get autoremove --purge -y

WORKDIR /tmp
RUN curl -o ruby.tgz \
    "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR}/ruby-${RUBY_VERSION}.tar.gz" && \
  tar -xzf ruby.tgz && \
  cd ruby-${RUBY_VERSION} && \
  ./configure --enable-shared --with-jemalloc --disable-install-doc && \
  make -j4 && \
  make install && \
  rm /usr/local/lib/libruby-static.a

ENV GEM_SPEC_CACHE "/tmp/gemspec"
RUN echo 'gem: --no-document' > $HOME/.gemrc
RUN gem update --system ${RUBYGEMS_VERSION}
RUN gem install -v ${BUNDLER_VERSION} bundler

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

RUN useradd -m app
RUN mkdir /home/app/webapp && chown app:app -R /home/app

RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt /var/lib/dpkg /usr/share/man /usr/share/doc
