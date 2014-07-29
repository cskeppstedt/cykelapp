define ['vendor/backbone', 'vendor/underscore'], (Backbone, _) ->
  Backbone.View.extend
    tagName: 'li'
    template: '<%= name %>'

    render: ->
      tmpl = $('#station-search-item-template').html()
      @$el.html (_.template tmpl, { station: @model })