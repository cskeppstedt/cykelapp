define [
  'vendor/backbone'
  'vendor/underscore'
  'vendor/typeahead.bundle'
], (Backbone, _) ->

  'use strict'

  StationFinder = Backbone.View.extend
    wait: 300
    currentText: ''
    resultTemplate: $('#results-category').html()

    events:
      'click .location': 'openSearch'
      'keyup :text': 'filter'
      'blur :text': 'closeSearch'


    initialize: (@options) ->
      @collection = @options.collection


    render: ->
      tmpl = _.template $('#location-template').html()

      @$el.html tmpl
        header: @header
        val: @el

      @collection.fetch
        success: (result) => @_setupTypeahead result.models


    filter: ->
      if not @engine then return

      query = @$el.find(':text').val()

      @engine.get query, (suggestions) =>
        @$el.find('.results').html _.template @resultTemplate,
          title: 'Sökresultat'
          items: _.map suggestions, (suggestion) -> suggestion


    openSearch: ->
      @$el.find('.location').addClass('focus')
      @$el.find(':text').select()


    closeSearch: ->
      @$el.find('.location').removeClass('focus')


    _setupTypeahead: (stationModels) ->
      datumTokenizer = (datum) -> _.values(datum).join(' ').split(/(\s|\/)/)

      @engine = new Bloodhound
        datumTokenizer: datumTokenizer
        queryTokenizer: Bloodhound.tokenizers.whitespace
        local: $.map stationModels, (model) ->
          value: model.get('name')

      @engine.initialize()

