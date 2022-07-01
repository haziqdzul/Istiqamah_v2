import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';

import '../Locale/locales.dart';
import '../constants/constant.dart';

class Rday extends StatefulWidget {
  const Rday({Key? key}) : super(key: key);

  @override
  State<Rday> createState() => _RdayState();
}

class _RdayState extends State<Rday> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(locale.religiousday!),
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
                Card(
                    color: Colors.yellow[50],
                    elevation: 5,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Isra miraj',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Icon(Icons.info_outline_rounded)),
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
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Maulidur Rasul',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Icon(Icons.info_outline_rounded)),
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
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Eid Al-Fitr',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Icon(Icons.info_outline_rounded)),
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
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Eid Al-Adha',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Icon(Icons.info_outline_rounded)),
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
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Ramadan',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Icon(Icons.info_outline_rounded)),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
