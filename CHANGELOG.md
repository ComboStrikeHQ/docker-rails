# Changelog

## master (unreleased)

## 1.6.0 (2015-02-02)

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
