define [
  'vendor/backbone'
  'router'
  'collections/stations'
  'views/navigator'
  'views/map'
], (Backbone, Router, StationsCollection, NavigatorView, MapView) ->

  'use strict'

  navView  = new NavigatorView()
  mapView  = new MapView()
  stations = new StationsCollection()

  init = () ->
    router = new Router()

    router.on 'route:home', ->
      navView.render()
      mapView.render()

    Backbone.history.start()

  return {
    init: init
  }
