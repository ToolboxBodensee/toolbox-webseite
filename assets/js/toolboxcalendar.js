$(document).ready(function() {
  var currentView = 'month';
  if ($(window).width() <= 480) {
    currentView = 'listWeek';
  }
  $('#calendar').fullCalendar({
    height: 1000,
    defaultView: currentView,
    timezone: 'local',
    weekends: true
  });
  $('#calendar').fullCalendar('addEventSource', ical_event_source('/termine.ics', 'green', ''));
  setInterval(() => $('#calendar').fullCalendar('refetchEvents'), 5 * 60 * 1000);
  setInterval(() => $('#calendar').fullCalendar('gotoDate', moment()), 30 * 60 * 1000);
});
