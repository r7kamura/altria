$ ->
  $('.jobs_controller.index_action').each ->
    new Altria.ServerEvent().on 'build.started build.finished', (attributes) ->
      $.ajax
        url: "/jobs/#{attributes.job_id}",
        success: (data) ->
          $("#job#{attributes.job_id}").replaceWith(data)

  $('.jobs_controller.show_action').each ->
    event = new Altria.ServerEvent()

    event.on 'build.finished', (attributes) ->
      $.ajax
        url: "/builds/#{attributes.id}"
        success: (data) ->
          $("#build#{attributes.id}").replaceWith(data)

    event.on 'build.started', (attributes) ->
      $.ajax
        url: "/builds/#{attributes.id}"
        success: (data) ->
          $('.builds ul').prepend(data)
