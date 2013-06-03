# Magi
A continuous integration server implementation.

## Install
```
$ gem install magi
$ brew install mysql redis # or other commands to install MySQL and Redis
```

## Usage
```
$ gem install magi
$ magi setup
$ magi start # open http://localhost:3000
```

## Hack
Magi is just a rails application.
Feel free to do what you want.

```
$ git clone git@github.com:r7kamura/magi.git
$ cd magi
$ brew install redis
$ redis-server (in background)
$ bundle install
$ bundle exec rake db:create db:migrate
$ rails s
```

## Architecture
* Rails: HTTP server
* Sidekiq: background worker
* Redis: worker queue
* MySQL: store jobs & builds

## ToDo
* scheduling system
* plugin system
* cli options (e.g. port, RAILS_ENV, redis conf)
