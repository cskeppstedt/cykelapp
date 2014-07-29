requirejs.config
  shim:
    'vendor/backbone':
      deps: ['vendor/underscore', 'vendor/jquery']
      exports: 'Backbone'
    'vendor/backbone-fixtures':
      deps: ['vendor/backbone', 'vendor/jquery']
      exports: 'BackboneFixtures'
    'vendor/underscore':
      exports: '_'
  map:
    '*':
      'underscore': 'vendor/underscore'


require ['vendor/backbone', 'vendor/backbone-fixtures', 'app'], (Backbone, BackboneFixtures, App) ->
  Backbone.fixtures = true
  Backbone.fixturesRoot = '/fixtures/'
  App.init()