# Magi
A continuous integration server implementation.

![](http://dl.dropbox.com/u/5978869/image/20130607_012059.png)

## Install
```
$ gem install magi
$ brew install mysql redis # or other commands to install MySQL and Redis
```

## Usage
```
$ magi setup
$ magi start # open http://localhost:3000
```

## Hack
Magi is just a rails application with some middlewares.

* clockwork: scheduler
* foreman: process manager
* mysql: store jobs & builds
* resque: background worker using redis

## Todo
* async update by ajax
* command-line options

## API
[API documents](https://github.com/r7kamura/magi/blob/master/doc)
