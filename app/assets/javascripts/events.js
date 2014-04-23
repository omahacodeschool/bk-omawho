$(document).ready(function(){
  $(".upcoming_event_bar").on("click", function(event) {
    if ( $(this).next(".event_display").is(":visible") ) {
      $(this).next(".event_display").hide();
    } else {
      $(this).next(".event_display").show();
    }
  });
  
  $(".past_event_bar").on("click", function(event) {
    if ( $(this).next(".event_display").is(":visible") ) {
      $(this).next(".event_display").hide();
    } else {
      $(this).next(".event_display").show();
    }
  });
});