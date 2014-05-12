jQuery ->
  
  # only allow the user to select 3 categories
  $('input[type=checkbox]').change (e) ->
    if $('input[type=checkbox]:checked').length > 3 
      $(this).prop('checked', false)