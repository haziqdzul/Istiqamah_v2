import 'package:flutter/material.dart';
import 'package:istiqamah_app/calendar/flutter_neat_and_clean_calendar.dart';
import 'package:istiqamah_app/calendar/islamic.event.dart';

//
class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<NeatCleanCalendarEvent> _todaysEvents = [
    NeatCleanCalendarEvent('Event A',
        startTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        endTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        ),
        description: 'A special event',
        color: Colors.blue[700]),
  ];

  @override
  void initState() {
    super.initState();
    //TODO Force selection of today on first load, so that the list of today's events gets shown.
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  @override
  Widget build(BuildContext context) {
    final eventList = eventLists();
    return Scaffold(
      body: SafeArea(
        child: Calendar(
          startOnMonday: true,
          weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          eventsList: eventLists(),
          isExpandable: true,
          eventDoneColor: Colors.green[400],
          selectedColor: Colors.lime[900],
          selectedTodayColor: Colors.amber,
          todayColor: Colors.orange,
          eventColor: null,
          locale: 'en',
          todayButtonText: 'Today',
          allDayEventText: 'All day',
          multiDayEndText: 'End',
          isExpanded: true,
          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
          datePickerType: DatePickerType.date,
          dayOfWeekStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber,
        child: const Icon(Icons.notifications_none_rounded),
      ),
    );
  }

  void _handleNewDate(date) {
    print('Date selected: $date');
  }
}
