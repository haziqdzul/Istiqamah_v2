import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

import '../Locale/locales.dart';
import '../constants/constant.dart';
import '../stepperTouch/stepper_touch.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({Key? key}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    // New date selected
                    setState(() {});
                  },
                ),
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

  Widget _iconText(Icon icon, String title) {
    SizedBox left = SizedBox(
      width: 30,
      height: 30,
      child: icon,
    );

    Column right = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: const TextStyle(color: Colors.black)),
      ],
    );

    return Row(
      children: <Widget>[left, const SizedBox(width: 10), right],
    );
  }
}
