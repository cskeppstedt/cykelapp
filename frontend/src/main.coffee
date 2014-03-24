requirejs.config
  paths:
    jquery:     'http://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min'
    underscore: 'http://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min'
    backbone:   'http://cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.2/backbone-min'
    backbonefixtures: '../vendor/backbone-fixtures'

  shim:
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    backbonefixtures:
      deps: ['backbone', 'jquery']

require ['backbone', 'backbonefixtures', 'router', 'views/home'], (Backbone, BackboneFixtures, Router, HomeView) ->
  
  # $.ajaxPrefilter (options, originalOptions, jqHXR) ->
    # TODO options.url = 'http://cykelapp.appspot.com/api' + options.url
    # options.url = 'http://backbonejs-beginner.herokuapp.com' + options.url
  Backbone.fixtures = true
  Backbone.fixturesRoot = '../fixtures/'

  homeView = new HomeView()
  router = new Router()

  router.on 'route:home', ->
    homeView.render()

  Backbone.history.start()