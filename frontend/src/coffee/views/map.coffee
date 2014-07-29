define ['vendor/backbone', 'vendor/underscore'], (Backbone, _) ->
  Backbone.View.extend
    el: '#map'
    render: ->
      console.log 'map render'
      tmpl = $('#map-template').html()
      @$el.html (_.template tmpl, {})