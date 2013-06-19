class window.Magi.BuildView
  constructor: () ->
    @model = new Magi.Model()
    @model.onChange => @render()

  element: ->
    $("#build#{@model.attributes.id}")

  render: ->
    if element = @element()
      element.removeClass()
      element.addClass(@model.attributes.status)
      element.find('.time').text(@model.attributes.finished_at)
