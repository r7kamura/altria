class window.Magi.BuildView
  constructor: () ->
    @model = new Backbone.Model()
    @model.on 'change', => @render()

  element: ->
    $("#build#{@model.get('id')}")

  render: ->
    @element()
      .removeClass()
      .addClass(@model.get('status'))
      .find('.time').text(@model.get('finished_at'))
