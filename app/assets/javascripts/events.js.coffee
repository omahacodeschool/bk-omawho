jQuery ->
  $(".upcoming_event_bar").on "click", (e) ->
    if $(this).next(".event_display").is(":visible")
      $(this).next(".event_display").slideUp()
    else
      $(this).next(".event_display").slideDown()
  
  $('.row').on 'click', '.past_event_bar', (e) ->
    console.log("1")
    if $(this).next(".event_display").is(":visible")
      $(this).next(".event_display").slideUp()
    else
      $(this).next(".event_display").slideDown()

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