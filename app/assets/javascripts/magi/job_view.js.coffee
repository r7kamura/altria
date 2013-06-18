class window.Magi.JobView
  constructor: (@job) ->

  element: ->
    $("#job#{@job.attributes.job_id}")

  render: ->
    @element().removeClass()
    @element().addClass(@job.attributes.status)
