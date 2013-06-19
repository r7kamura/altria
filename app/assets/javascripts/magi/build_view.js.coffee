class window.Magi.BuildView
  constructor: () ->
    @model = new Magi.Model()
    @model.onChange => @render()

  element: ->
    $("#build#{@model.attributes.id}")

  render: ->
    @element()
      .removeClass()
      .addClass(@model.attributes.status)
      .find('.time').text(@model.attributes.finished_at)
