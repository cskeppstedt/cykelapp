define ['backbone', 'views/stationSearchItem'], (Backbone, ItemView)->
  Backbone.View.extend
    tagName: 'ul'
    wait: 300
    currentText: ''
    itemView: ItemView,

    initialize: (options) ->
      _.extend @, options
      @filter = _.debounce @filter, @wait

    filter: (keyword) ->
       keyword = keyword.toLowerCase()

    render: ->
      tmpl = _.template $('#station-search-template').html()
      
      @$el.html tmpl
        header: @header
        val: @el