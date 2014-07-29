define ['vendor/backbone', 'router', 'collections/stations', 'views/navigator', 'views/map', 'views/stationSearch'], (Backbone, Router, StationsCollection, NavigatorView, MapView, StationSearchView) ->
  navView  = new NavigatorView()
  mapView  = new MapView()
  stations = new StationsCollection()

  # searchView = new StationSearchView
  #   input: $('searchbox')
  #   model: stations

  init = () ->
    router = new Router()

    router.on 'route:home', ->
      navView.render()
      mapView.render()
      # searchView.render()

    Backbone.history.start()

  return {
    init: init
  }
