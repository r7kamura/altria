$ ->
  $('.jobs_controller.index_action').each ->
    job = new Magi.Model()
    view = new Magi.JobView(job)
    job.onChange -> view.render()
    event = new Magi.ServerEvent()
    event.on 'build.started', (attributes) -> job.set(attributes)
    event.on 'build.finished', (attributes) -> job.set(attributes)

  $('.jobs_controller.show_action').each ->
    view = new Magi.BuildView()
    event = new Magi.ServerEvent()
    event.on 'build.finished', (attributes) -> view.model.set(attributes)
