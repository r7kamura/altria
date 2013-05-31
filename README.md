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
$ redis-server
$ bundle install
$ bundle exec sidekiq
$ bundle exec rake db:create db:migrate
$ rails s
```

## ToDo
* scheduling system
* worker process management
* html interface
* json interface
* magi command
