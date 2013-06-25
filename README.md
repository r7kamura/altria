# Magi [![Build Status](https://travis-ci.org/r7kamura/magi.png?branch=master)](https://travis-ci.org/r7kamura/magi) [![Code Climate](https://codeclimate.com/github/r7kamura/magi.png)](https://codeclimate.com/github/r7kamura/magi) [![Coverage Status](https://coveralls.io/repos/r7kamura/magi/badge.png)](https://coveralls.io/r/r7kamura/magi)
Casual CI server system (magi is a temporal name).

![](http://gifzo.net/f2zmQFtkzv.gif)

## Usage
```
# Install mysql & redis
$ brew install mysql redis

# From github (recommended)
$ git clone git@github.com:r7kamura/magi
$ cd magi
$ ./bin/magi setup
$ ./bin/magi start
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

## Plugins
* [magi-git](https://github.com/r7kamura/magi-git): Git integration plugin
* [magi-simple_cov](https://github.com/r7kamura/magi-simple_cov): Save simplecov coverage for each build
* [magi-pipeline](https://github.com/r7kamura/magi-pipeline): Lets your job to kick another job after finished

```ruby
# Put your favorite plugin gems into Gemfile.local
gem "magi-git", git: "git@github.com:r7kamura/magi-git.git"
gem "magi-simple_cov", git: "git@github.com:r7kamura/magi-simple_cov.git"
gem "magi-pipeline", git: "git@github.com:r7kamura/magi-pipeline.git"
```
