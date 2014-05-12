jQuery ->
  
  # toggle view of events details
  $('.row').click '.upcoming_event_bar, .past_event_bar', (e) ->
    $(this).next(".event_display").slideToggle()
  
  # add your face to events you are going to
  $(".attendance_button").on "click", (e) ->
    e.preventDefault
    $(".attendance_button").removeClass("the_one")
    $(this).addClass("the_one")
    if $(this).text() == "I'M NOT GOING"
      $(this).text("I'M GOING")
      $(this).prev().text(parseInt($(this).prev().text()) - 1)
    else 
      $(this).text("I'M NOT GOING")
      $(this).prev().text(parseInt($(this).prev().text()) + 1)