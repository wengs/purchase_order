function check_if_a_form_changed(form, error_message) {
  $(form).change(function() {
    var _this = this;
    window.onbeforeunload = function(e) {
      var confirmationMessage = error_message;
      (e || window.event).returnValue = confirmationMessage;
      return confirmationMessage;
    }
  });

  // disable warning if submitting PO form
  $(form).submit(function(event){
    window.onbeforeunload = null;
  });
}
