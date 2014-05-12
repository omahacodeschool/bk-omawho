jQuery ->

  setTimeout () ->
    $("#flash_notice,#flash_alert").slideUp()
  , 2000

  $(".workinthathover").mouseenter () ->
    $(this).children(".display_name").removeClass( "display_name_hidden" ).addClass( "display_name_visibile" )
    $(this).children(".category_name").removeClass( "category_name_hidden" ).addClass( "category_name_visibile" )
    $(this).children("a").children(".index_image").css( "opacity", ".2" )

  $(".workinthathover").mouseleave () ->
   $(this).children(".display_name").removeClass( "display_name_visibile" ).addClass( "display_name_hidden" )
   $(this).children(".category_name").removeClass( "category_name_visibile" ).addClass( "category_name_hidden" )
   $(this).children("a").children(".index_image").css( "opacity", "1" )

  $("#topnavtext").click () ->
    $(".drop_down").slideToggle( "goaway" )

  $("#mobile_menu_bar p").click () ->
    $("#mobile_menu_bar ul").slideToggle( "goaway" )
