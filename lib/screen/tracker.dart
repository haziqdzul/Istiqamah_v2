import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../Locale/locales.dart';
import '../constants/constant.dart';
import '../stepperTouch/stepper_touch.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({Key? key}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  final DateTime _selectedDate = DateTime.now();
  final String? expandableDateFormat = 'EEEE dd MMMM yyyy';
  late String local = language();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting(local, null).then((_) => setState(() {
          DateFormat('MMMM yyyy', local).format(_selectedDate);
        }));
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(locale.tracker!, textAlign: TextAlign.center),
          backgroundColor: kSecondaryColor,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/app_coming_soon2.jpg'),
                fit: BoxFit.fill),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Container(
                  height: 70,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        DateFormat(expandableDateFormat, local)
                            .format(_selectedDate),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        HijriCalendar.fromDate(_selectedDate)
                            .toFormat("dd MMMM yyyy"),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                // DatePicker(
                //   DateTime.now(),
                //   //initialSelectedDate: DateTime.now(),
                //   // selectionColor: Colors.black,
                //   // selectedTextColor: Colors.white,
                //   // onDateChange: (date) {
                //   //   // New date selected
                //   //   setState(() {});
                //   // },
                // ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                    color: Colors.yellow[50],
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.sunny_snowing),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                locale.fajr!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StepperTouch(
                            initialValue: 0,
                            withSpring: false,
                            onChanged: (int value) => print('new value $value'),
                          ),
                        ),
                      ],
                    )),
                Card(
                    color: Colors.yellow[50],
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.sunny),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                locale.dhuhr!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StepperTouch(
                            initialValue: 0,
                            withSpring: false,
                            onChanged: (int value) => print('new value $value'),
                          ),
                        ),
                      ],
                    )),
                Card(
                    color: Colors.yellow[50],
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.sunny),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                locale.asr!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StepperTouch(
                            initialValue: 0,
                            withSpring: false,
                            onChanged: (int value) => print('new value $value'),
                          ),
                        ),
                      ],
                    )),
                Card(
                    color: Colors.yellow[50],
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.sunny_snowing),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                locale.maghrib!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StepperTouch(
                            initialValue: 0,
                            withSpring: false,
                            onChanged: (int value) => print('new value $value'),
                          ),
                        ),
                      ],
                    )),
                Card(
                    color: Colors.yellow[50],
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.nightlight),
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                locale.isha!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StepperTouch(
                            initialValue: 0,
                            withSpring: false,
                            onChanged: (int value) => print('new value $value'),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
