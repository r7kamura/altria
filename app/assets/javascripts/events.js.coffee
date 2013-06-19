$ ->
  $('.jobs_controller.index_action').each ->
    new Magi.ServerEvent().on 'build.started build.finished', (attributes) ->
      view = new Magi.JobView
        el: "#job#{attributes.job_id}"
        model: new Backbone.Model(attributes)
      view.render()

  $('.jobs_controller.show_action').each ->
    view = new Magi.BuildView()
    event = new Magi.ServerEvent()
    event.on 'build.finished', (attributes) ->
      view.model.set(attributes)
