requirejs.config
  paths:
    jquery:     '../vendor/jquery' #'http://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min'
    underscore: '../vendor/underscore' #'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min'
    backbone:   '../vendor/backbone' #'http://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.2/backbone-min'
    #backbonemodelbinder: 'http://cdnjs.cloudflare.com/ajax/libs/backbone.modelbinder/1.0.5/Backbone.ModelBinder.min'
    backbonefixtures: '../vendor/backbone-fixtures'

  shim:
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    backbonefixtures:
      deps: ['backbone', 'jquery']
    #backbonemodelbinder:
    #  deps: ['backbone', 'jquery']

require ['backbone', 'backbonefixtures', 'app'], (Backbone, BackboneFixtures, App) ->
  Backbone.fixtures = true
  Backbone.fixturesRoot = '../fixtures/'
  App()