$ ->
  $('.jobs_controller.index_action').each ->
    new Altria.ServerEvent().on 'build.started build.finished', (attributes) ->
      view = new Altria.JobView
        el: "#job#{attributes.job_id}"
        model: new Backbone.Model(attributes)
      view.render()

  $('.jobs_controller.show_action').each ->
    view = new Altria.BuildView()
    event = new Altria.ServerEvent()
    event.on 'build.finished', (attributes) ->
      view.model.set(attributes)
