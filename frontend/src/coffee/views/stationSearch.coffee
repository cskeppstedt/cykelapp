define ['vendor/backbone', 'vendor/underscore'], (Backbone, _)->
  Backbone.View.extend
    wait: 300
    currentText: ''

    initialize: (options) ->
      _.extend @, options
      @filter = _.debounce @filter, @wait

    filter: (keyword) ->
       keyword = keyword.toLowerCase()

    render: ->
      tmpl = _.template $('#location-template').html()

      @$el.html tmpl
        header: @header
        val: @el

    openSearch: ->
      @$el.find('.location').addClass 'focus'

    events:
      'click .location': 'openSearch'