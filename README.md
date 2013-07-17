# Altria [![Build Status](https://travis-ci.org/r7kamura/altria.png?branch=master)](https://travis-ci.org/r7kamura/altria) [![Code Climate](https://codeclimate.com/github/r7kamura/altria.png)](https://codeclimate.com/github/r7kamura/altria) [![Coverage Status](https://coveralls.io/repos/r7kamura/altria/badge.png)](https://coveralls.io/r/r7kamura/altria)
Altria is a casual CI server, implemented with Ruby on Rails.

![](http://gifzo.net/f2zmQFtkzv.gif)

## Usage
```
# Install mysql & redis
$ brew install mysql redis

# From github (recommended)
$ git clone git@github.com:r7kamura/altria
$ cd altria
$ ./bin/altria setup
$ ./bin/altria start
```

## Development
Altria is just a rails application with some middlewares.

* rails4: notify build start/finish events via live streaming
* clockwork: cron scheduler
* foreman: process manager
* mysql: store jobs & builds
* resque: background worker using redis
* jquery: ajax updated view
* redis: build started/finished notification by pubsub system
* autodoc: generate [RESTful API documents](https://github.com/r7kamura/altria/blob/master/doc) from request-specs

## Plugins
* [altria-authentication](https://github.com/r7kamura/altria-authentication): Provides authentication system
* [altria-git](https://github.com/r7kamura/altria-git): Git integration plugin
* [altria-pipeline](https://github.com/r7kamura/altria-pipeline): Lets your job to kick another job after finished
* [altria-processing_time](https://github.com/r7kamura/altria-processing_time): Display each build's processing time graph on job page
* [altria-simple_cov](https://github.com/r7kamura/altria-simple_cov): Save simplecov coverage for each build

```ruby
# Put your favorite plugin gems into Gemfile.local
gem "altria-authentication", git: "git@github.com:r7kamura/altria-authentication.git"
gem "altria-git", git: "git@github.com:r7kamura/altria-git.git"
gem "altria-simple_cov", git: "git@github.com:r7kamura/altria-simple_cov.git"
gem "altria-pipeline", git: "git@github.com:r7kamura/altria-pipeline.git"
gem "altria-processing_time", git: "git@github.com:r7kamura/altria-processing_time.git"
```
