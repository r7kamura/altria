class window.Magi.ServerEvent
  constructor: ->
    @source = new EventSource('/events')

  onBuildStart: (callback) ->
    @source.addEventListener 'build.start', (event) ->
      callback($.parseJSON(event.data))

  onBuildFinish: (callback) ->
    @source.addEventListener 'build.finish', (event) ->
      callback($.parseJSON(event.data))
