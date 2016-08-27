$(document).on('turbolinks:load', function() {
  $('form#new_user').on('ajax:error', function(event, xhr, status, error) {
    $('#login-alerts').replaceWith(
      "<div id='login-alerts' class='alert alert-danger'>"
      + "Sorry, that didn't work"
      + "</div>"
    )
  });
})
