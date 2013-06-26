window.Altria.JobView = Backbone.View.extend
  initialize: () ->

  render: ->
    console.log(@el)
    console.log(@$el)
    @$el.removeClass().addClass(@status())

  status: ->
    @model.get('status')
