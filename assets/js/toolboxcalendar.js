$(document).ready(function() {
    $('#calendar').fullCalendar({
      height: 1000,
      defaultView: 'month',
      timezone: 'local',
      weekends: true
    });
    $('#calendar').fullCalendar('addEventSource', ical_event_source('https://toolbox-bodensee.de/termine.ics', 'green', ''));
    setInterval(() => $('#calendar').fullCalendar('refetchEvents'), 5 * 60 * 1000);
    setInterval(() => $('#calendar').fullCalendar('gotoDate', moment()), 30 * 60 * 1000);
});