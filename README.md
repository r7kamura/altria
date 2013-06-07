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
Magi is just a rails application.
Feel free to do what you want.

### tools
* Clockwork: scheduler
* Foreman: process manager
* MySQL: store jobs & builds
* Rails: HTTP server
* Redis: worker queue
* Resque: background worker

### todo
* plugin system
* cli options (e.g. http port, rails env, redis conf)
