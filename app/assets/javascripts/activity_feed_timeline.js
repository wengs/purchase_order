var currentData = [];

setInterval(function() {
  var newData = [];
  $.ajax({
    url: '/activities.json',
    success: function(data) {
      updateTimeline(currentData, data);
    },
    error: function() {
      console.log("Error getting data.")
    }
  });
}, 20000);

function updateTimeline(oldData, newData) {
  if (oldData.length === 0) {

    for (var i = 0; i < newData.length; i++) {

      var newTimelineItem = JSON.stringify(newData[i]['name']).replace(/^"(.+(?="$))"$/, '$1');
      var newDate = JSON.stringify(newData[i]['date']).replace(/^"(.+(?="$))"$/, '$1');
      $(".offsidebar-activity-feed").prepend("<div class='media-box p mt0'><p class='pull-left'><span class='fa fa-history'><span> " + newTimelineItem + "</p><div class='pull-right'><span class='label label-green'>" + newDate.toLocaleString() + "</span></div></div>");
    }

  } else {

    var currentTopItemId = oldData[oldData.length-1]['id'];

    if (currentTopItemId !== newData[newData.length-1]['id']) {

      for (var i = 0; i < newData.length; i++) {

        if (newData[i]['id'] > currentTopItemId) {

          var newTimelineItem = JSON.stringify(newData[i]['name']).replace(/^"(.+(?="$))"$/, '$1');
          var newDate = JSON.stringify(newData[i]['date']).replace(/^"(.+(?="$))"$/, '$1');
          $(".offsidebar-activity-feed").prepend("<div class='media-box p mt0'><p class='pull-left'><span class='fa fa-rss'><span> " + newTimelineItem + "</p><div class='pull-right'><span class='label label-green'>" + newDate.toLocaleString() + "</span></div></div>");
        }
      }
    }
  }
  currentData = newData;
};