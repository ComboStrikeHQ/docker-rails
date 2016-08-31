# Docker-Rails
[![Circle CI](https://circleci.com/gh/ad2games/docker-rails.svg?style=svg)]
(https://circleci.com/gh/ad2games/docker-rails)

An opinionated docker image for running Rails apps in production.

Uses Puma, Sidekiq, Clockwork and rails_migrate_mutex.
Everything is optional.

## Quick Example
- Create a new Rails app (`$ rails new my_blog`)
- Create a `Dockerfile` in the app root with this content: `FROM ad2games/docker-rails:latest`
- Add `gem 'puma'` to the `Gemfile` and run `bundle install`
- Build the docker container: `$ docker build -t my_blog .`
- Run the container: `$ docker run -p 8080:8080 -e RAILS_ENV=development my_blog`
- Open `http://localhost:8080`
- Enjoy!

This example is for demo purposes only.
Docker-Rails is intended for production use, not local development.
Please read the whole README before using.

## Docker Image
The image is built by us, squashed into a single layer and pushed to
[Docker Hub](https://registry.hub.docker.com/u/ad2games/docker-rails/).

To use it in your app, create a `Dockerfile` with the following content:

```docker
FROM ad2games/docker-rails:<VERSION>
```

and replace `<VERSION>` with the [current version number](CHANGELOG.md).

Add more docker steps if needed (usually not), build and deploy to your infrastructure.

We use [eb_deployer](https://github.com/ThoughtWorksStudios/eb_deployer) to deploy our apps
to [AWS Elastic Beanstalk](https://aws.amazon.com/de/elasticbeanstalk/).

## Contents

### Rails App Server / Puma
[Puma](http://puma.io/) is used as the web server for your app.
For this to work properly, please add the following gems to your Gemfile:

```ruby
gem 'puma'
gem 'rack-timeout', group: :production
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
[Sidekiq](http://sidekiq.org/) is used for processing background jobs. A sidekiq process
will be automatically started when the `sidekiq` gem is present in your app. Using sidekiq is
optional.

You can configure sidekiq:

Environment Variable | Description | Default Value
--- | --- | ---
SIDEKIQ_THREADS | Number of threads | 16

You can also create a `config/sidekiq.yml` file in your app that contains additional configuration.

The default configuration enables the `default` and `mailers` queues.

### Clockwork
[Clockwork](https://github.com/tomykaira/clockwork) is used for scheduling background jobs.
A clockwork process will be automatically started when the `clockwork` gem is present in your app.
Using clockwork is optional.

You need to create a `config/clockwork.rb` file using the following schema:
```ruby
module Clockwork
  every(1.hour, 'my_job') { MyWorker.perform_async }
end
```

Note that the clockwork process is started in every container. We recommend using
[sidekiq-unique-jobs](https://github.com/mhenrixon/sidekiq-unique-jobs) to ensure that jobs
are scheduled only once.

### Rails Migrations / rails_migrate_mutex
[rails_migrate_mutex](https://github.com/ad2games/rails_migrate_mutex) is used to run Rails
migrations. If you have the gem installed in you app, migrations are automatically run on
container startup. Using rails_migrate_mutex is optional.

### Ruby / Packages
The latest ruby version is included in the container. It is compiled from source and uses
[jemalloc](http://www.canonware.com/jemalloc/). The latest rubygems and bundler versions
are installed as well.

The following tools are installed: `git`, `nodejs`, `imagemagick`, `curl`, `bower`.
Development packages for compiling the following gems are included:
`sqlite3`, `pg`, `mysql2`, `nokogiri`.

Have a look at the [Base Dockerfile](base/Dockerfile) for more details.

### App Installation / Docker ONBUILD
The final docker image has ONBUILD hooks that set up your application.
It installs all gems except those in the `development` and `test` groups.

If the `sprockets`
gem is present (default for Rails apps), it also precompiles assets. If you need any environment
variables set for compiling assets, you can specify them in a `.env` file in your app root. This
file will be sourced before running the task. Newer versions of sprockets will also automatically
created gzipped versions of the assets. Rails then uses these static gzip files to serve assets.

Have a look at the [ONBUILD Dockerfile](onbuild/Dockerfile) for more details.

### Environment Variables
All environment variables are passed on the application. Both `RAILS_ENV` and `RACK_ENV` are
set to `production` and should not be changed.

## License

MIT, see LICENSE.txt

## Contributing

Please create a new GitHub Issue if you encounter a bug or have a feature request.

Feel free to fork and submit pull requests!
