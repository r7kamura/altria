# Magi
Yet another an open source continuous integration server.

## Easy mode
Simply invokes built-in commands.

```
$ gem install magi
$ magi setup
$ magi worker
$ magi web
```

## Hard mode
Magi is just a rails application. Feel free to do what you want.

```
$ git clone git@github.com:r7kamura/magi.git
$ cd magi
$ bundle install
$ bundle exec sidekiq
$ ./bin/magi web
```

## ToDo
* magi setup command
* magi start command
* worker process
* web interface application/json
* web interface text/html
