jQuery ->
  current_path = window.location.pathname
  $('.menu a[href="'+current_path+'"]').addClass("active")
  $('.view_selector a[href="'+current_path+'"]').addClass("active")
