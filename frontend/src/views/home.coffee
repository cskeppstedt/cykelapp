define ['backbone', 'collections/stations'], (Backbone, StationsCollection) ->
  Backbone.View.extend
    el: '.page'
    render: ->
      @$el.html 'LOADING'
      stations = new StationsCollection()
      tmpl = $('#station-list-template').html()
      self = @

      stations.fetch
        success: (stations) ->
          console.log 'success', stations
          self.$el.html (_.template tmpl, { stations: stations.models })
        error: (col, response, options) ->
          console.log 'error', col, response, options