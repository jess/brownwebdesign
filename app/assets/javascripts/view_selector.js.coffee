jQuery ->
  $("[data-view-style]").click ->
    link = $(@).attr("href")
    $("#posts").load "#{link} #posts"
    $('.view_selector a').removeClass("active")
    $('.view_selector a[href="'+link+'"]').addClass("active")
    return false
