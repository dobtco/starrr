(($, window) ->

  # Define the plugin class
  class Starrr
    defaults:
      rating: undefined
      numStars: 5
      change: (e, value) ->

    constructor: ($el, options) ->
      @options = $.extend({}, @defaults, options)
      @$el = $el

      for i, _ of @defaults
        @options[i] = @$el.data(i) if @$el.data(i)?

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
      @$el.append("""<i class='icon-star-empty'></i>""") for [1..@options.numStars]

    setRating: (rating) ->
      rating = undefined if @options.rating == rating
      @options.rating = rating
      @syncRating()
      @$el.trigger('starrr:change', rating)

    syncRating: (rating) ->
      rating ||= @options.rating

      if rating
        for i in [0..rating - 1]
          @$el.find('i').eq(i).removeClass('icon-star-empty').addClass('icon-star')

      if rating && rating < 5
        for i in [rating..4]
          @$el.find('i').eq(i).removeClass('icon-star').addClass('icon-star-empty')

      if !rating
        @$el.find('i').removeClass('icon-star').addClass('icon-star-empty')

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
