import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istiqamah_app/calendar/flutter_neat_and_clean_calendar.dart';
import '../Locale/locales.dart';
import '../constants/constant.dart';
import 'islamic.event.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: Align(
            child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            //size: 20,
            color: Colors.black,
          ),
        )),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        //automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Calendar(
            startOnMonday: true,
            weekDays: [
              locale.mon!,
              locale.tue!,
              locale.wed!,
              locale.thu!,
              locale.fri!,
              locale.sat!,
              locale.sun!
            ],
            eventsList: eventLists(context),
            onRangeSelected: (range) =>
                // ignore: avoid_print
                print('Range is ${range.from}, ${range.to}'),
            onDateSelected: (date) => _handleNewDate(date),
            isExpandable: true,
            eventDoneColor: Colors.green[400],
            selectedColor: Colors.lime[400],
            todayColor: Colors.orange,
            eventColor: null,
            locale: language(),
            todayButtonText: locale.today!,
            isExpanded: true,
            expandableDateFormat: 'EEEE, dd. MMMM yyyy',
            dayOfWeekStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              insetPadding: const EdgeInsets.all(15),
              child: StatefulBuilder(builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Icon(
                      Icons.timelapse_outlined,
                    ),
                    Text(locale.soon!),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      locale.fastingreminder!,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }),
            ),
          );
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.notifications_none_rounded),
      ),
    );
  }

  void _handleNewDate(date) {
    if (kDebugMode) {
      print('Date selected: $date');
    }
  }

  language() {
    String? locale;
    var box = GetStorage();
    if (box.read('lang') == 'id') {
      locale = 'ms';
    } else {
      locale = 'en';
    }
    return locale;
  }
}
