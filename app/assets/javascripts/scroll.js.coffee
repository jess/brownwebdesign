jQuery ->
  $("[data-down-arrow]").click ->
    background = $(@).parents("section")
    next = background.next()
    scrollTo(next)
    return false

  $("[data-up-arrow]").click ->
    first = $("section").eq(0)
    scrollTo(first)
    return false



scrollTo = (element) ->
  $('html, body').animate({
    scrollTop: element.offset().top
  }, 1000);
