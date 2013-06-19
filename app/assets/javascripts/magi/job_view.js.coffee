class window.Magi.JobView
  constructor: () ->
    @model = new Magi.Model()
    @model.on 'change', => @render()

  element: ->
    $("#job#{@model.attributes.job_id}")

  render: ->
    @element().removeClass().addClass(@model.attributes.status)
