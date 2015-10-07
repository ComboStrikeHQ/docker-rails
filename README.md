# Docker-Rails
[![Circle CI](https://circleci.com/gh/ad2games/docker-rails.svg?style=svg)]
(https://circleci.com/gh/ad2games/docker-rails)

An opinionated docker image for running Rails apps in production.

Uses Puma, Sidekiq, Logentries, New Relic and rails_migrate_mutex. Everything is optional.

## Quick Example
- Create a new Rails app (`$ rails new my_blog`)
- Create a `Dockerfile` in the app root with this content: `FROM ad2games/docker-rails:latest`
- Add `gem 'puma'` to the `Gemfile` and run `bundle install`
- Build the docker container: `$ docker build -t my_blog .`
- Run the container: `$ docker run -p 8080:8080 -e RAILS_ENV=development my_blog`
- Open `http://localhost:8080` (use `docker-machine ip <name>` output on OS X)
- Enjoy!

This example is for demo purposes only.
Docker-Rails is intended for production use, not local development.
Please read the whole README before using.

## Docker Image
The image is built by us, squashed into a single layer and pushed to
[Docker Hub](https://registry.hub.docker.com/u/ad2games/docker-rails/).

To use it in your app, create a `Dockerfile` with the following content:

```docker
FROM ad2games/docker-rails:latest
```

Add more docker steps if needed (usually not), build and deploy to your infrastructure.

## Contents

### Rails App Server / Puma
We use [Puma](http://puma.io/) as the web server for our app. For this to work properly, please
add the following gems to your Gemfile:

```ruby
gem 'puma'
gem 'rails_12factor', group: :production
```

You can configure Puma:

Environment Variable | Description | Default Value
--- | --- | ---
PUMA_WORKERS | Number of worker processes | [number of CPU cores]
PUMA_MAX_THREADS | Maximum number of threads per process | 16
PUMA_MIN_THREADS | Minimum number of threads per process | PUMA_MAX_THREADS

You can also create a `config/puma.rb` file in your app that contains additional configuration.

Have a look at the [Puma configuration file](base/puma.rb) for more details.

### Sidekiq
We use [Sidekiq](http://sidekiq.org/) for processing background jobs. A sidekiq process
will be automatically started when the `sidekiq` gem is present in your app. Using sidekiq is
optional.

You can configure sidekiq:

Environment Variable | Description | Default Value
--- | --- | ---
SIDEKIQ_THREADS | Number of threads | 16

You can also create a `config/sidekiq.yml` file in your app that contains additional configuration.

The default configuration enables the `default` and `mailers` queues.

### Logging / Logentries
We use [Logentries](https://logentries.com/) for application logging. If you provide a
Logentries token, app server and sidekiq log output if forwarded to Logentries. Using Logentries
is optional.

We recommend using the [lograge](https://github.com/roidrage/lograge) gem for better log output.

You can configure Logentries logging:

Environment Variable | Description | Default Value
--- | --- | ---
LOGENTRIES_API_TOKEN | Your Logentries token | _empty/disabled_

Have a look at the [syslog-ng configuration file](base/syslog-ng.logentries.conf) for more details.

### Rails Migrations / rails_migrate_mutex
We use [rails_migrate_mutex](https://github.com/ad2games/rails_migrate_mutex) to run Rails
migrations. If you have the gem installed in you app, migrations are automatically run on
container startup. Using rails_migrate_mutex is optional.

### New Relic Server Monitor
We use the [New Relic Server Monitor](http://newrelic.com/server-monitoring) to monitor our
containers. If you provide a New Relic token, the server monitor daemon starts automatically.
Using New Relic Server Monitoring is optional.

Environment Variable | Description | Default Value
--- | --- | ---
NEW_RELIC_LICENSE_KEY | Your New Relic token | _empty/disabled_

### Ruby / Packages
The latest ruby version is included in the container. It is compiled from source and uses
[jemalloc](http://www.canonware.com/jemalloc/). The latest rubygems and bundler versions
are installed as well.

The following tools are installed: `git`, `nodejs`, `imagemagick`, `curl`.
Development packages for compiling the following gems are included: `sqlite3`, `pg`, `nokogiri`.

Have a look at the [Base Dockerfile](base/Dockerfile) for more details.

### App Installation / Docker ONBUILD
The final docker image has ONBUILD hooks that set up your application.
It installs all gems except those in the `development` and `test` groups.

If the `sprockets`
gem is present (default for Rails apps), it also precompiles assets. If you need any environment
variables set for compiling assets, you can specify them in a `.env` file in your app root. This
file will be sourced before running the task.

Have a look at the [ONBUILD Dockerfile](onbuild/Dockerfile) for more details.

### Environment Variables
All environment variables are passed on the application. Both `RAILS_ENV` and `RACK_ENV` are
set to `production` and should not be changed.

## License

MIT, see LICENSE.txt

## Contributing

Feel free to fork and submit pull requests!
