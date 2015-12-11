(($, window) ->

  # Define the plugin class
  window.Starrr = class Starrr
    defaults:
      rating: undefined
      numStars: 5
      emptyStarClass: 'fa fa-star-o'
      fullStarClass: 'fa fa-star'
      change: (e, value) ->

    constructor: ($el, options) ->
      @options = $.extend({}, @defaults, options)
      @$el = $el

      for i, _ of @defaults
        @options[i] = @$el.data(i.toLowerCase()) if @$el.data(i.toLowerCase())?

      if @$el.data('connected-input')
        @$connectedInput = $("[name=\"#{@$el.data('connected-input')}\"]")
        @options.rating = if @$connectedInput.val() then parseInt(@$connectedInput.val(), 10) else undefined

      @createStars()
      @syncRating()

      return if @$connectedInput && @$connectedInput.is(':disabled') || @$el.data('disabled')

      @$el.on 'mouseover.starrr', 'i', (e) =>
        @syncRating(@getStars().index(e.currentTarget) + 1)

      @$el.on 'mouseout.starrr', =>
        @syncRating()

      @$el.on 'click.starrr', 'i', (e) =>
        @setRating(@getStars().index(e.currentTarget) + 1)

      @$el.on 'starrr:change', @options.change

      if @$connectedInput?
        @$el.on 'starrr:change', (e, value) =>
          @$connectedInput.val(value)
          @$connectedInput.trigger('focusout') # trigger change

    getStars: ->
      @$el.find('i')

    createStars: ->
      @$el.append("""<i class='#{@options.emptyStarClass}'></i>""") for [1..@options.numStars]

    setRating: (rating) ->
      rating = undefined if @options.rating == rating
      @options.rating = rating
      @syncRating()
      @$el.trigger('starrr:change', rating)

    getRating: ->
      @options.rating

    syncRating: (rating) ->
      rating ||= @options.rating

      if rating
        for i in [0..rating - 1]
          @getStars().eq(i).removeClass(@options.emptyStarClass).addClass(@options.fullStarClass)

      if rating && rating < @options.numStars
        for i in [rating..(@options.numStars - 1)]
          @getStars().eq(i).removeClass(@options.fullStarClass).addClass(@options.emptyStarClass)

      if !rating
        @getStars().removeClass(@options.fullStarClass).addClass(@options.emptyStarClass)

  # Define the plugin
  $.fn.extend starrr: (option, args...) ->
    @each ->
      data = $(@).data('starrr')

      if !data
        $(@).data 'starrr', (data = new Starrr($(@), option))
      if typeof option == 'string'
        data[option].apply(data, args)

) window.jQuery, window
