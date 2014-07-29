define ['vendor/backbone', 'models/station'], (Backbone, StationModel) ->
  Backbone.Collection.extend
    model: StationModel
    url: 'http://cykelapp.appspot.com/api/stations'
    fixture: 'stations'