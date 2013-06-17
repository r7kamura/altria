$ ->
  $('.jobs_controller.index_action').each ->
    source = new EventSource('/events')

    source.addEventListener 'build.start', (event) ->
      data = $.parseJSON(event.data)
      data.type = 'start'
      console.log(data)

    source.addEventListener 'build.finish', (event) ->
      data = $.parseJSON(event.data)
      data.type = 'finish'
      console.log(data)
