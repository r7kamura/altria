$ ->
  $('.jobs_controller.index_action').each ->
    new Altria.ServerEvent()
      .on 'build.started build.finished', (attributes) ->
        $.ajax "/jobs/#{attributes.job_id}", success: (data) ->
          $("#job#{attributes.job_id}").replaceWith(data)

  $('.jobs_controller.show_action').each ->
    new Altria.ServerEvent()
      .on 'build.finished', (attributes) ->
        $.ajax "/builds/#{attributes.id}", success: (data) ->
          $("#build#{attributes.id}").replaceWith(data)
      .on 'build.started', (attributes) ->
        $.ajax "/builds/#{attributes.id}", success: (data) ->
          $('.builds ul').prepend(data)
