jQuery ->
  $(".name_game_company").on 'click', () ->
    $('input:radio').attr('checked',false)
    $(this).children().first().attr('checked',true)
    if $(this).hasClass("gray_choice")
      $(this).removeClass("gray_choice")
      $(this).addClass("red_choice")
      $(this).siblings().removeClass("red_choice")
      $(this).siblings().addClass("gray_choice")
    else
      $(this).removeClass("red_choice")
      $(this).addClass("gray_choice")