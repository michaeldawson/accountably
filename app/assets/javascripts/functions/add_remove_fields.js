$(document).on('ready turbolinks:load', function() {
  $('.add_remove_fields').addRemoveFields();
});

$.widget('custom.addRemoveFields', {
  _create: function() {
    this.$element = $(this.element);

    this.$element.on('click', '.add_fields', this._handleAddFields);
    this.$element.on('click', '.remove_fields', this._handleRemoveFields);
  },

  _handleAddFields: function(e) {
    var regexp = new RegExp($(this).data('id'), 'g'),
        time   = new Date().getTime();

    var content   = $(this).data('fields').replace(regexp, time);
    $(this).closest('.addFieldsContext').before(content);

    e.preventDefault();
  },

  _handleRemoveFields: function(e) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.fieldset').hide();
    e.preventDefault();
  },
});
