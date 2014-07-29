define ['vendor/backbone', 'collections/stations', 'views/stationSearch'], (Backbone, StationsCollection, StationSearch) ->
  Backbone.View.extend
    el: '#navigator'

    initialize: ->
      @collection = new StationsCollection()

    render: ->
      console.log 'navigator render'

      fromSearch = new StationSearch
        collection: @collection
        header: 'From'
        el: '#station-from'

      toSearch = new StationSearch
        collection: @collection
        header: 'To'
        el: '#station-to'

      fromSearch.render()
      toSearch.render()

      # @collection.fetch
      #   success: (stations) ->
      #     console.log 'success', stations
      #     self.$el.html (_.template tmpl, { stations: stations.models })
      #   error: (col, response, options) ->
      #     console.log 'error', col, response, options