# Magi [![Code Climate](https://codeclimate.com/github/r7kamura/magi.png)](https://codeclimate.com/github/r7kamura/magi)
Casual CI server system (magi is a temporal name).

## Usage
```
$ gem install magi         # install magi.gem
$ brew install mysql redis # install MySQL and Redis
$ magi setup               # create mysql tables
$ magi start               # launch server on http://localhost:3000
```

## Development
Magi is just a rails application with some middlewares.

* rails4: notify build start/finish events via live streaming
* clockwork: cron scheduler
* foreman: process manager
* mysql: store jobs & builds
* resque: background worker using redis
* jquery: ajax updated view
* redis: build started/finished notification by pubsub system
* autodoc: generate [RESTful API documents](https://github.com/r7kamura/magi/blob/master/doc) from request-specs

### TODO
* authentication (with read, write)
* build stop button
* self-repairing system
* plugin updater
