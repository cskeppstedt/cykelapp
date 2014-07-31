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
    'vendor/typeahead.bundle':
      deps: ['vendor/jquery']
  map:
    '*':
      'underscore': 'vendor/underscore'


require [
  'vendor/backbone'
  'vendor/backbone-fixtures'
  'app'
], (Backbone, BackboneFixtures, App) ->

  'use strict'

  Backbone.fixtures = true
  Backbone.fixturesRoot = '/fixtures/'
  App.init()