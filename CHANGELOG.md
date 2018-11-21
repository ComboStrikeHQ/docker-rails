# Changelog

## 2.8.1 (2018-02-15)

- Upgrade Ruby (2.5.3)
- Upgrade rubygems (2.7.8)
- Upgrade bundler (1.17.1)

## 2.7.3 (2018-02-15)

- Add `file` command

- Upgrade Ruby (2.5.0)
- Upgrade rubygems (2.7.4)
- Upgrade bundler (1.16.1)
- Upgrade NodeJS (8.9.4 LTS)
- Upgrade phusion/baseimage (0.10.0)

## 2.7.2 (2018-01-25)

- Introduce ruby-2.4 version tag

## 2.7.1 (2018-01-02)

- Upgrade Ruby (2.4.3)
- Upgrade rubygems (2.6.14)
- Upgrade bundler (1.16.1)

## 2.7.0 (2017-12-22)

- Allow to run additional application services

## 2.6.2 (2017-09-13)

- Add `LIBRATO_AUTORUN` to sidekiq environment

## 2.6.1 (2017-07-20)

- Close Active Record connections [PR #15](https://github.com/ad2games/docker-rails/pull/15)

## 2.6.0 (2017-01-26)

- Upgrade rubygems
- Upgrade bundler
- Upgrade bower
- Switch to NodeJS LTS
- Add support for vendored gems

## 2.5.0 (2016-09-22)

- Add support for Rails 5 native 12-factor config
- Remove puma request logging
- Wait for syslog-ng to start

## 2.4.2 (2016-09-19)

- Fix application server logs missing

## 2.4.1 (2016-09-01)

- Fix asset precompilation when pg gem is not present

## 2.4.0 (2016-08-31)

- Add support for mysql2 gem
- Clean up README

## 2.3.0 (2016-07-26)

- Upgrade baseimage, rubygems, bundler and node

## 2.2.1 (2016-06-03)

- Add proper exit handling for Clockwork

## 2.2.0 (2016-05-18)

- Reduce number of layers in ONBUILD Dockerfile
- Upgrade ruby, rubygems, bundler and nodejs
- Fix graceful shutdown for Puma workers

## 2.1.1 (2016-05-13)

- Allow writing to app directory during ONBUILD

## 2.1.0 (2016-04-06)

- Upgrade rubygems, nodejs and bower
- Do not fail in puma boot when there is no ActiveRecord

## 2.0.1 (2016-02-08)

- Fix bug where everything is logged twice

## 2.0.0 (2016-02-08) BREAKING CHANGES, see README

- Remove logentries and NewRelic server monitor

## 1.6.0 (2016-02-02)

- Upgrade bower to 1.7.6
- Upgrade rubygems to 2.5.2
- Upgrade nodejs to 5.5.0

## 1.5.0 (2016-01-15)

- Upgrade to Ruby 2.3.0
- Upgrade to nodejs 5.3.1 and bower 1.7.2
- Ruby: Enable shared lib and remove static lib
- Speed up tests by removing one `bundle install` call

## 1.4.0 (2015-12-23)

- Allow writing to vendor directory during ONBUILD
- Set HOME in ONBUILD Dockerfile
- Add bower
- Use recent nodejs version
- Update to baseimage-docker 0.9.18
- Remove manual gzipping of assets - newer sprockets versions do that automatically
- Lock rubygems and bundler version

## 1.3.0 (2015-12-17)

- Upgrade to Ruby 2.2.4

## 1.2.2 (2015-11-27)

- Make some ONBUILD commands regular ones

## 1.2.1 (2015-11-12)

- Add prefix to docker tags (for development only)
- Use COPY in ONBUILD Dockerfile

## 1.2.0 (2015-10-28)

- Add gzip compression for asset files

## 1.1.1 (2015-10-10)

- Also log stderr output for all processes

## 1.1.0 (2015-10-09)

- Add clockwork support

## 1.0.2 (2015-10-09)

- Fix sidekiq default queues precedence

## 1.0.1 (2015-10-08)

- Fix custom `puma.rb` configuration

## 1.0.0 (2015-10-08)

- Initial release
