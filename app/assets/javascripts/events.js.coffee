$ ->
  $('.jobs_controller.index_action').each ->
    view = new Magi.JobView()
    event = new Magi.ServerEvent()
    event.on 'build.started', (attributes) -> view.model.set(attributes)
    event.on 'build.finished', (attributes) -> view.model.set(attributes)

  $('.jobs_controller.show_action').each ->
    view = new Magi.BuildView()
    event = new Magi.ServerEvent()
    event.on 'build.finished', (attributes) -> view.model.set(attributes)
