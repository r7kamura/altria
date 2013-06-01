# Magi
A continuous integration server implementation.

## Ingredients
* Ruby
* Rails
* Redis
* MySQL

## Usage
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

## Testing
```
$ git clone git@github.com:r7kamura/magi.git
$ cd magi
$ bundle install
$ RAILS_ENV=test bundle exec rake db:create db:migrate
$ bundle exec rspec
```

## ToDo
* scheduling system
* worker process management
* html interface
* json interface
* magi command
* extensible plugin system

## Architecture
* Almost all records in magi system are stored as a file (e.g. job config, system config, and build logs)
