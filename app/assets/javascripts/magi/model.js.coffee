class window.Magi.Model
  constructor: (@attributes = {}) ->

  set: (attributes) ->
    @attributes[key] = value for key, value of attributes
    @change()

  onChange: (callback) ->
    @callback = callback

  change: ->
    @callback()
