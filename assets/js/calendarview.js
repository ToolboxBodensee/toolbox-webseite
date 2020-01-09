// Any copyright is dedicated to the Public Domain.
// http://creativecommons.org/publicdomain/zero/1.0/

// Return an EventSource that fetches events from the ICAL file at `url`.
function ical_event_source(url, color, filter) {
  return {
    id: url,
    events: (start, end, timezone, callback) => {
      fetch(url).then((response) => {
        return response.text()
      }).then((data) => {
        var comp = new ICAL.Component(ICAL.parse(data));
        var events = comp.getAllSubcomponents('vevent').map(ve => new ICAL.Event(ve));
        var filter_events = events.filter(entry => !filter || new RegExp(filter).test(entry.summary));
        var our_events = Array()
        filter_events.forEach(function(element) {
          var end = ICAL.Time.now();
          end.adjust(360, 0, 0, 0);
          var it = element.iterator();
          var entry;
          while (entry = it.next()) {
              var t = entry.clone();
              t.addDuration(element.duration);
              if (t.compare(end) == 1) break;
              var event = {
                id: element.uid,
                title: element.summary,
                allDay: element.startDate.isDate,
                start: entry.toJSDate(),
                end: t.toJSDate(),
                color: color,
                location: element.location,
                description: element.description
              };
              our_events.push(event);
          }
        });
        callback(our_events);
      });
    }
  };
}

