$ ->
  $('.jobs_controller.index_action').each ->
    new Altria.ServerEvent()
      .on 'build.started build.finished', (attributes) ->
        $.ajax "/jobs/#{attributes.job_id}", success: (data) ->
          $("#job#{attributes.job_id}").replaceWith(data)

  $('.jobs_controller.show_action').each ->
    event = new Altria.ServerEvent()
    event.on 'build.finished', (attributes) ->
      if location.pathname == "/jobs/#{attributes.job_id}"
        $.ajax "/builds/#{attributes.id}", data: { type: 'list' }, success: (data) ->
          $("#build#{attributes.id}").replaceWith(data)
    event.on 'build.started', (attributes) ->
      if location.pathname == "/jobs/#{attributes.job_id}"
        $.ajax "/builds/#{attributes.id}", data: { type: 'list' }, success: (data) ->
          $('.builds ul').prepend(data)

  $('.builds_controller.show_action').each ->
    new Altria.ServerEvent()
      .on 'build.finished', (attributes) ->
        if location.pathname == "/builds/#{attributes.id}"
          $.ajax "/builds/#{attributes.id}", success: (data) ->
            $('body').html(data)
