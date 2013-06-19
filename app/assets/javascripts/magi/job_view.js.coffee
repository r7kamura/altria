class window.Magi.JobView
  constructor: () ->
    @model = new Backbone.Model()
    @model.on 'change', => @render()

  element: ->
    $("#job#{@model.get('job_id')}")

  render: ->
    @element().removeClass().addClass(@model.get('status'))
