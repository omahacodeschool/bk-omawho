jQuery ->
  # Submit the photo form automatically.
  $('#profile_photo_field').on 'change', () ->
    $('#upload_profile_photo').submit()
    
  # Photo form: Hide field, show 'loading'.
  $('#upload_profile_photo').on 'submit', () ->
    $('#profile_photo_before').hide()
    $('#profile_photo_after').show()
    
  # Validation: Alert if photo is absent.
  $('#user_form').on 'submit', (e) ->
    if !$("#profile_photo_id").val()?.length
      alert("Add your face! (Use the photo upload field at the top of the form.)")
      e.preventDefault()    
  