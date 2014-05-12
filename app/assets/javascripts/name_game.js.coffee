jQuery ->
  
  $(".name_game_company").on 'click', () ->
    
    # select the associated radio box
    $('input:radio').attr('checked',false)
    $(this).children().first().attr('checked',true)
    
    # if it is not selected, select it, and deselect the others
    if $(this).hasClass("gray_choice")
      $(this).removeClass("gray_choice").addClass("red_choice")
      $(this).siblings().removeClass("red_choice").addClass("gray_choice")
    
    # if it is selected, deselect it
    else
      $(this).removeClass("red_choice").addClass("gray_choice")