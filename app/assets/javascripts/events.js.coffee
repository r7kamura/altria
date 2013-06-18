$ ->
  $('.jobs_controller.index_action').each ->
    job = new Magi.JobModel()
    view = new Magi.JobView(job)
    job.onChange -> view.render()

    event = new Magi.ServerEvent()
    event.onBuildStart (attributes) -> job.set(attributes)
    event.onBuildFinish (attributes) -> job.set(attributes)
