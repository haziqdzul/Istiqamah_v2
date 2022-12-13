import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../Locale/locales.dart';
import '../constants/constant.dart';
import 'webPage.dart';

class Rday extends StatefulWidget {
  const Rday({Key? key}) : super(key: key);

  @override
  State<Rday> createState() => _RdayState();
}

class _RdayState extends State<Rday> {
  var box = GetStorage();
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
                RdayCard(
                  onPress: () {
                    if (box.read('lang') == 'En') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WikiView(
                                  link:
                                      'https://en.wikipedia.org/wiki/Islamic_New_Year',
                                  title: 'Islamic New Year')));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WikiView(
                                  link:
                                      'https://ms.wikipedia.org/wiki/Awal_Muharam',
                                  title: 'Awal Muharam')));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          locale.tahunbaru!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Icon(Icons.info_outline_rounded)),
                    ],
                  ),
                ),
                RdayCard(
                  onPress: () {
                    if (box.read('lang') == 'En') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WikiView(
                                  link:
                                      'https://en.wikipedia.org/wiki/Muharram',
                                  title: 'Muharam')));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WikiView(
                                  link: 'https://ms.wikipedia.org/wiki/Muharam',
                                  title: 'Muharam')));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Muharam',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Icon(Icons.info_outline_rounded)),
                    ],
                  ),
                ),
                RdayCard(
                    onPress: () {
                      if (box.read('lang') == 'En') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://en.wikipedia.org/wiki/Isra_and_Mi%27raj',
                                      title: 'Isra miraj',
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                    link:
                                        'https://ms.wikipedia.org/wiki/Israk_dan_Mikraj',
                                    title: 'Israk dan Mikraj')));
                      }
                    },
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
                RdayCard(
                    onPress: () {
                      if (box.read('lang') == 'En') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://en.wikipedia.org/wiki/Mawlid',
                                      title: 'Mawlid',
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                    link:
                                        'https://ms.wikipedia.org/wiki/Maulidur_Rasul',
                                    title: 'Maulidur Rasul ')));
                      }
                    },
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
                RdayCard(
                    onPress: () {
                      if (box.read('lang') == 'En') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://en.wikipedia.org/wiki/Ramadan',
                                      title: 'Ramadan',
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://ms.wikipedia.org/wiki/Ramadan',
                                      title: 'Ramadan',
                                    )));
                      }
                    },
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
                RdayCard(
                    onPress: () {
                      if (box.read('lang') == 'En') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://en.wikipedia.org/wiki/Eid_al-Fitr',
                                      title: locale.fitr!,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://ms.wikipedia.org/wiki/Hari_Raya_Aidilfitri',
                                      title: locale.fitr!,
                                    )));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            locale.fitr!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Icon(Icons.info_outline_rounded)),
                      ],
                    )),
                RdayCard(
                    onPress: () {
                      if (box.read('lang') == 'En') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://en.wikipedia.org/wiki/Day_of_Arafah',
                                      title: locale.arafah!,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                    link:
                                        'https://ms.wikipedia.org/wiki/Hari_Arafah',
                                    title: locale.arafah!)));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            locale.arafah!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Icon(Icons.info_outline_rounded)),
                      ],
                    )),
                RdayCard(
                    onPress: () {
                      if (box.read('lang') == 'En') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://en.wikipedia.org/wiki/Eid_al-Adha',
                                      title: locale.adha!,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WikiView(
                                      link:
                                          'https://ms.wikipedia.org/wiki/Hari_Raya_Aidiladha',
                                      title: locale.adha!,
                                    )));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            locale.adha!,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const Padding(
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

class RdayCard extends StatelessWidget {
  RdayCard({
    required this.onPress,
    required this.child,
  });

  VoidCallback onPress;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // margin: EdgeInsets.all(10),
      onTap: onPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.yellow[50],
            elevation: 5,
            shadowColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: child,
          ),
        ],
      ),
    );
  }
}
