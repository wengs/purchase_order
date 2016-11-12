//= require 'tables'
//= require 'forms'
//= require 'check_if_a_form_changed'

$("input#graphic_information_required").change(function() {
  $('textarea[name="graphic[notes_information_required]"]').attr("disabled", !this.checked);
});

$("input#graphic_files_needed").change(function() {
  $('textarea[name="graphic[notes_files_needed]"]').attr("disabled", !this.checked);
});

check_if_a_form_changed('form.simple_form.edit_graphic', "If you leave this form before Updating the graphic, you will lose any changes.");
