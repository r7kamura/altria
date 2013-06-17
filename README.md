# Magi
A continuous integration server implementation.

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
* autodoc: generate [RESTful API documents](https://github.com/r7kamura/magi/blob/master/doc) from request-specs

### TODO
* ajax updated view
* build stop button
* self-repairing system
* plugin updater
