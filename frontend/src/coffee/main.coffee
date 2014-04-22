requirejs.config
  paths:
    #backbonemodelbinder: 'http://cdnjs.cloudflare.com/ajax/libs/backbone.modelbinder/1.0.5/Backbone.ModelBinder.min'
    backbonefixtures: '../vendor/backbone-fixtures'

  shim:
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    backbonefixtures:
      deps: ['backbone', 'jquery']
      exports: 'BackboneFixtures'
    #backbonemodelbinder:
    #  deps: ['backbone', 'jquery']

require ['backbone', 'backbonefixtures', 'app'], (Backbone, BackboneFixtures, App) ->
  Backbone.fixtures = true
  Backbone.fixturesRoot = '../fixtures/'
  App()