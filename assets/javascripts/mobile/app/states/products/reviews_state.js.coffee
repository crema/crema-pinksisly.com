class ProductsReviewsState
  on_enter: (old_state_name, args) ->
    $("#topbar li.sort-container").show()

    args.elements.find(".show-reviews-index").click ->
      app.window.redirect_to $(this).data("reviews-index-url")

    app.search_toggle.init(args.elements)
    app.search.init(args.elements.find(".menu"))

  refresh_filter: ->
    url_builder = new UrlBuilder(lib.history.get_current_url())
    url_builder.remove_param("page")
    url_builder.add_param("aloading", ".page")

    $link_photo_reviews = $("a.link-photo-reviews")
    if $link_photo_reviews.hasClass("selected")
      url_builder.add_param("filter", $link_photo_reviews.data("filter"))
    else
      url_builder.remove_param("filter")

    $.getScript url_builder.build()

  on_exit: (new_state_name, args) ->
    $("#topbar li.sort-container").hide()

app.products_reviews_state = new ProductsReviewsState

$(document).on "history:updated", (e, element) ->
  $element = $(element)
  $element.find("a.link-photo-reviews").click (e) ->
    $(e.currentTarget).toggleClass("selected")
    app.products_reviews_state.refresh_filter()
