class window.Magi.Model
  _.extend(@prototype, Backbone.Events)

  constructor: (@attributes = {}) ->

  set: (attributes) ->
    @attributes[key] = value for key, value of attributes
    @trigger('change')
