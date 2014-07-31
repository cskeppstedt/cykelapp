define [
  'vendor/backbone'
  'collections/stations'
  'views/station_finder'
], (Backbone, StationsCollection, StationFinder) ->

  Navigator = Backbone.View.extend
    el: '#navigator'

    initialize: ->
      @collection = new StationsCollection()

    render: ->
      fromSearch = new StationFinder
        collection: @collection
        header: 'From'
        el: '#station-from'

      toSearch = new StationFinder
        collection: @collection
        header: 'To'
        el: '#station-to'

      fromSearch.render()
      toSearch.render()
