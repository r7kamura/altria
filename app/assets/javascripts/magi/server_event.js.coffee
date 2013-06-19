class window.Magi.ServerEvent
  constructor: ->
    @source = new EventSource('/events')

  on: (string, callback) ->
    for eventName in string.split(' ')
      @source.addEventListener eventName, (event) ->
        callback($.parseJSON(event.data))
