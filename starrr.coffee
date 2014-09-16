(($, window) ->

  # Define the plugin class
  class Starrr
    defaults:
      rating: undefined
      emptyStarClass: 'fa fa-star-o'
      fullStarClass: 'fa fa-star'
      numStars: 5
      change: (e, value) ->

    constructor: ($el, options) ->
      @options = $.extend({}, @defaults, options)
      @$el = $el

      for i, _ of @defaults
        @options[i] = @$el.data(i.toLowerCase()) if @$el.data(i.toLowerCase())?

      console.log @options

      @createStars()
      @syncRating()

      @$el.on 'mouseover.starrr', 'i', (e) =>
        @syncRating(@$el.find('i').index(e.currentTarget) + 1)

      @$el.on 'mouseout.starrr', =>
        @syncRating()

      @$el.on 'click.starrr', 'i', (e) =>
        @setRating(@$el.find('i').index(e.currentTarget) + 1)

      @$el.on 'starrr:change', @options.change

    createStars: ->
      @$el.append("""<i class='#{@options.emptyStarClass}'></i>""") for [1..@options.numStars]

    setRating: (rating) ->
      @options.rating = if @options.rating == rating then undefined else rating
      @syncRating()
      @$el.trigger('starrr:change', @options.rating)

    syncRating: (rating) ->
      rating ||= @options.rating

      if rating
        for i in [0..rating - 1]
          @$el.find('i').eq(i).removeClass(@options.emptyStarClass).addClass(@options.fullStarClass)

      if rating && rating < @options.numStars
        for i in [rating..(@options.numStars - 1)]
          @$el.find('i').eq(i).removeClass(@options.fullStarClass).addClass(@options.emptyStarClass)

      if !rating
        @$el.find('i').removeClass(@options.fullStarClass).addClass(@options.emptyStarClass)

  # Define the plugin
  $.fn.extend starrr: (option, args...) ->
    @each ->
      data = $(@).data('star-rating')

      if !data
        $(@).data 'star-rating', (data = new Starrr($(@), option))
      if typeof option == 'string'
        data[option].apply(data, args)

) window.jQuery, window

$ ->
  $(".starrr").starrr()
