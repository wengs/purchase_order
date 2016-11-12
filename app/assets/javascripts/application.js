// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//

//--- Angle
//= require_tree ./angle/

function milestoneSearch() {
  var Selector = document.getElementById("q_milestone_id_eq");
  var Index = Selector.options[Selector.selectedIndex].value;
  document.getElementById("po_search").submit();
}