import 'dart:convert';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:istiqamah_app/models/azan.model.dart';
import 'package:istiqamah_app/screen/time_in_hour_and_minute.dart';

class GetApi extends StatefulWidget {
  const GetApi({Key? key}) : super(key: key);

  @override
  State<GetApi> createState() => _GetAPIState();
}

class _GetAPIState extends State<GetApi> {
  String? fajr;

  String? imsak;

  String? sunrise;

  String? dhuhr;

  String? asr;

  String? susnset;

  String? maghrib;

  String? isha;

  String? midnight;

  Position? currentPosition;
  String currentAddress = 'My Location';
  static double? pLat;
  static double? pLong;

  Future<Position> fetchPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    pLat = position.latitude;
    pLong = position.longitude;

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pLat!, pLong!);

      Placemark place = placemarks[0];

      setState(() {
        currentPosition = position;
        currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }

    return position;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosition().then((value) {
      // getPrayerTimes(currentPosition!.latitude, currentPosition!.longitude);
      getResponse(
          DateTime.now().day - 1,
          DateTime.now().month,
          DateTime.now().year,
          currentPosition!.latitude,
          currentPosition!.longitude);
    });
  }

  String? status;
  int? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(height: 60),
                  TimeInHourAndMinute(),
                  Row(
                    children: [
                      _iconText(
                        const Icon(
                          Icons.location_on,
                          color: Colors.black38,
                          size: 15,
                        ),
                        currentAddress,
                      ),
                      TextButton(
                          onPressed: () {
                            fetchPosition().then((value) {
                              setState(() {
                                // getPrayerTimes(currentPosition!.latitude,
                                //     currentPosition!.longitude);

                                getResponse(
                                    DateTime.now().day - 1,
                                    DateTime.now().month,
                                    DateTime.now().year,
                                    currentPosition!.latitude,
                                    currentPosition!.longitude);
                              });
                            });
                          },
                          child: const Text('Update'))
                    ],
                  ),
                ],
              ),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {});
                  getResponse(date.day - 1, date.month, date.year,
                      currentPosition!.latitude, currentPosition!.longitude);
                },
              ),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.access_alarm),
                title: const Text('Imsak'),
                subtitle: Text('$imsak'),
              )),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.access_alarm),
                title: const Text('Fajar'),
                subtitle: Text('$fajr'),
              )),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.sunny_snowing),
                title: const Text('Sunrise'),
                subtitle: Text('$sunrise'),
              )),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.access_alarm),
                title: const Text('Zohor'),
                subtitle: Text('$dhuhr'),
              )),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.access_alarm),
                title: const Text('Asar'),
                subtitle: Text('$asr'),
              )),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.sunny),
                title: const Text('Sunset'),
                subtitle: Text('$susnset'),
              )),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.access_alarm),
                title: const Text('Maghrib'),
                subtitle: Text('$maghrib'),
              )),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.access_alarm),
                title: const Text('Isya'),
                subtitle: Text('$isha'),
              )),
              Card(
                  child: ListTile(
                leading: const Icon(Icons.nightlight_round),
                title: const Text('Midnight'),
                subtitle: Text('$midnight'),
              )),
            ],
          ),
        ));
  }

  Future<void> getResponse(
      int day, int month, int year, double latitude, double longitude) async {
    var url = Uri.parse(
        // 'https://api.aladhan.com/v1/calendarByCity?city=Kuala%20Lumpur&country=Malaysia&method=2&month=$month&year=$year');
        "http://api.aladhan.com/v1/calendar?latitude=$pLat&longitude=$pLong&method=2&month=$month&year=$year");
    var response = await http.get(url);
    var data = Azan.fromJson(json.decode(response.body));
    setState(() {});
    status = data.status;
    code = data.code;
    fajr = data.data![day].timings!.fajr;
    imsak = data.data![day].timings!.imsak;
    sunrise = data.data![day].timings!.sunrise;
    dhuhr = data.data![day].timings!.dhuhr;
    asr = data.data![day].timings!.asr;
    susnset = data.data![day].timings!.sunset;
    maghrib = data.data![day].timings!.maghrib;
    isha = data.data![day].timings!.isha;
    midnight = data.data![day].timings!.midnight;
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
