//= require 'tables'
//= require 'forms'
//= require 'check_if_a_form_changed'

$(function() {
  function addTopScrollBar(topScrollBar, contentName, contentWidth) {
    // Set top scroll-bar nested div width same as #graphics-list table's width
    $(topScrollBar).children('div').width(contentWidth);

    // synchronize topScrollBar and content's scrollBar
    $(topScrollBar).scroll(function(){
      $(contentName).scrollLeft($(topScrollBar).scrollLeft());
    });
    $(contentName).scroll(function(){
      $(topScrollBar).scrollLeft($(contentName).scrollLeft());
    });
  }

  $("input#po_information_required").change(function() {
    $('textarea[name="po[notes_information_required]"]').attr("disabled", !this.checked);
  });

  $("input#po_files_needed").change(function() {
    $('textarea[name="po[notes_file_needed]"]').attr("disabled", !this.checked);
  });
  // $("select[name='po[milestone_id]']").change(function () {
  //   $('textarea[name="po[notes_information_required]"]').prop("disabled", $("input#po_information_required").value() == 1);

  //   } else if ($("select[name='po[milestone_id]'] option:selected").text() === "Files Needed") {
  //     $('textarea[name="po[notes_information_required]"]').attr("disabled", true);
  //     $('textarea[name="po[notes_file_needed]"]').prop("disabled", false);
  //   } else {
  //     $('textarea[name="po[notes_information_required]"]').attr("disabled", true);
  //     $('textarea[name="po[notes_file_needed]"]').attr("disabled", true);
  //   }
  // });

  $("#graphic_search th select.ransack-search-select").change(function () {
    $("form#graphic_search").submit();
  });

  addTopScrollBar("#graphics-list-top-scroll-bar", "#graphics-list", $("#graphics-list table").width());
  addTopScrollBar("#pos-list-top-scroll-bar", "#pos-list", $("#pos-list table").width())

  check_if_a_form_changed('form.simple_form.edit_po', "If you leave this form before Updating the PO, you will lose any changes. This includes Quotes, Purchase Orders, and Invoices you have chosen to upload.");
})

