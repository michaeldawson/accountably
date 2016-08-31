// console.log('loading');
$(document).on('ready turbolinks:load', function() {
  $('input.date_picker').datepicker({
    format: "dd/mm/yyyy"
  });
});
