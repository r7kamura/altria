class window.Magi.ServerEvent
  constructor: ->
    @source = new EventSource('/events')

  on: (eventName, callback) ->
    @source.addEventListener eventName, (event) ->
      callback($.parseJSON(event.data))
