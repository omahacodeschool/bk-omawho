jQuery ->

  #set the delay for how long the flash messages are shown.
  setTimeout () ->
    $("#flash_notice,#flash_alert").slideUp()
  , 2000

  #add greyed out effect and name to photo
  $(".workinthathover").mouseenter () ->
    $(this).children(".display_name").removeClass( "display_name_hidden" ).addClass( "display_name_visibile" )
    $(this).children(".category_name").removeClass( "category_name_hidden" ).addClass( "category_name_visibile" )
    $(this).children("a").children(".index_image").css( "opacity", ".2" )

  #remove greyed out effect and name to photo
  $(".workinthathover").mouseleave () ->
   $(this).children(".display_name").removeClass( "display_name_visibile" ).addClass( "display_name_hidden" )
   $(this).children(".category_name").removeClass( "category_name_visibile" ).addClass( "category_name_hidden" )
   $(this).children("a").children(".index_image").css( "opacity", "1" )

  # show/hide the categories menu
  $("#topnavtext").click () ->
    $(".drop_down").slideToggle( "goaway" )

  # show/hide the mobile menu
  $("#mobile_menu_bar p").click () ->
    $("#mobile_menu_bar ul").slideToggle( "goaway" )
