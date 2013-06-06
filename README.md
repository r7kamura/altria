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
* Rails: HTTP server
* Sidekiq: background worker
* Redis: worker queue
* MySQL: store jobs & builds

### todo
* plugin system
* cli options (e.g. http port, rails env, redis conf)
