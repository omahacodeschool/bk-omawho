$(document).ready(function(){
  
  $(".workinthathover").mouseenter(function(){
    $(this).children(".display_name").removeClass( "display_name_hidden" ).addClass( "display_name_visibile" );
    $(this).children(".category_name").removeClass( "category_name_hidden" ).addClass( "category_name_visibile" );
    $(this).children("a").children(".testimage").css( "opacity", ".2" );
  }); 
  $(".workinthathover").mouseleave(function(){
   $(this).children(".display_name").removeClass( "display_name_visibile" ).addClass( "display_name_hidden" );
   $(this).children(".category_name").removeClass( "category_name_visibile" ).addClass( "category_name_hidden" );
   $(this).children("a").children(".testimage").css( "opacity", "1" );
  });
  $("#topnavtext2").click(function(){
    $(".drop_down").slideToggle( "goaway" );
  }); 
});