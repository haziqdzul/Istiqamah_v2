import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Utils/shimmer.dart';
import '../components/alert_button.dart';
import '../components/card_body.dart';
import '../components/default_circle.dart';
import '../components/default_dialog.dart';
import '../constants/constant.dart';
import '../fragments/update.profile.dart';
import '../models/user.model.dart';
import '../providers/cancel.notification.provider.dart';
import '../providers/languages.provider.dart';
import '../providers/medicine1.provider.dart';
import '../providers/medicine2.provider.dart';
import '../providers/user.provider.dart';
import '../providers/water.provider.dart';
import '../widgets/colors.dart';
import 'NavigationDrawer.dart';
import 'all.hadis.dart';
import 'package:istiqamah_app/Locale/locales.dart';
import 'package:async/async.dart';
import 'notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final List _list = [];
  final _stopLoad = AsyncMemoizer();
  List<String> _bookmark = [];
  bool _switch = false;
  final box = GetStorage();
  int currentDateSelectedIndex = 0;
  ScrollController scrollController = ScrollController();
  var a = '';
  var b = '';
  var c = '';
  var d = '';
  var e = '';
  var f = '';
  var waterPerday = 0;
  int? duration;
  bool isSwitched = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  bool isSwitched4 = false;
  bool isSwitched5 = false;
  bool med1 = false;
  bool med2 = false;
  bool firstTimeProduct = false;
  bool firstTimeWater = false;
  bool firstTimeSadaqah = false;
  bool firstTimeTahajjud = false;
  bool firstMed1 = false;
  bool firstMed2 = false;
  late TabController _tabController;

  final _name = TextEditingController();
  final _detailM = TextEditingController();

  bool? m1;
  bool? m2;
  var numbP = 0;
  var numbT = 0;
  var numbS = 0;
  var numbM1 = 0;
  var numbM2 = 0;
  var numbW = 0;
  bool hadis = false;
  late AsyncMemoizer _memoizer;
  var _currentSelectedValue;
  final _no = [
    "1",
    "2",
    "3",
    "4",
  ];

  bool visible = true;

  void back1() {
    setState(() {
      med1 = !med1;
    });
  }

  late bool waterLoad;
  late bool med1Load;
  late bool med2Load;
  late String code;

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
    waterLoad = Provider.of<WaterProvider>(context, listen: false).load;
    med1Load = Provider.of<Medicine1Provider>(context, listen: false).load;
    med2Load = Provider.of<Medicine2Provider>(context, listen: false).load;
    code = Provider.of<LanguageProvider>(context, listen: false).local;
    init();
    checkTime();
    checkWaterIntake();
    _tabController = TabController(length: 1, vsync: this);
    getAllHadis();
  }

  final List _product = [];
  final List _tahajjud = [];
  final List _sedekah = [];

  int i = 0;
  bool empty = false;

  Future<dynamic> countUnReadDocuments() async {
    await Future.delayed(const Duration(seconds: 2));
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .collection("notifications")
        .where("read", isEqualTo: false)
        .get();
    QuerySnapshot _allDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .collection("notifications")
        .get();
    List<DocumentSnapshot> _allDocCount = _allDoc.docs;
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    int ii = _myDocCount.length; // Count of Documents in Collection

    setState(() {
      i = ii;
    });

    if (_allDocCount.isEmpty) {
      setState(() {
        empty = true;
      });
    }
    return ii;
  }

  Future<void> init() async {
    countUnReadDocuments();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('new', false);
    Provider.of<Medicine1Provider>(context, listen: false).getMedicine();
    Provider.of<Medicine2Provider>(context, listen: false).getMedicine();
    var hasProduct = prefs.getBool('P${AppUser.instance.user!.uid}') ?? false;
    var hasWater = prefs.getBool('W${AppUser.instance.user!.uid}') ?? false;
    var hasSadaqah = prefs.getBool('S${AppUser.instance.user!.uid}') ?? false;
    var hasTahajjud = prefs.getBool('T${AppUser.instance.user!.uid}') ?? false;
    m1 = prefs.getBool('m1${AppUser.instance.user!.uid}') ?? false;
    m2 = prefs.getBool('m2${AppUser.instance.user!.uid}') ?? false;
    if (mounted) {
      setState(() {
        isSwitched = hasProduct;
        isSwitched2 = hasWater;
        isSwitched3 = hasSadaqah;
        isSwitched4 = hasTahajjud;
        med1 = m1!;
        med2 = m2!;
        currentDateSelectedIndex = DateTime.now().weekday - 1;
      });
    }
  }

  Future<void> createProductReminderNotification(DateTime d) async {
    var locale = AppLocalizations.of(context)!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('habbatus_madu')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (mounted) {
          setState(() {
            if (AppLocalizations.of(context)!.language != 'Language') {
              if (doc['terjemahanHadith'] != '' &&
                  doc['terjemahanHadith'].length < 400) {
                _product.add(
                    '${doc['terjemahanHadith']} (${doc['kitabDanNomborHadith']}) ');
              } else {
                if (doc['terjemahanQuran'] != '' &&
                    doc['terjemahanQuran'].length < 400) {
                  _product.add(
                      '${doc['terjemahanQuran']} (${doc['surahDanAyat']}) ');
                }
              }
            } else if (AppLocalizations.of(context)!.language == 'Language') {
              if (doc['translation_hadith'] != '' &&
                  doc['translation_hadith'].length < 400) {
                _product.add(
                    '${doc['translation_hadith']} (${doc['kitabDanNomborHadith']}) ');
              } else {
                if (doc['translation_quran'] != '' &&
                    doc['translation_quran'].length < 400) {
                  _product.add(
                      '${doc['translation_quran']} (${doc['surahDanAyat']}) ');
                }
              }
            }
          });
        }
      }
    });
    for (int i = 0; i < 30; i++) {
      var time = DateTime(
          d.year, d.month, d.day + i, d.hour, d.minute, d.second, 0, 0);
      if (mounted) {
        setState(() {
          Random random = Random();
          numbP = random.nextInt(_product.length);
          var str = _product[numbP]
              .replaceAll('�', '')
              .replaceAll('(?)', '')
              .replaceAll('?\n', '')
              .replaceAll('Rasulullah ?', 'Rasulullah');
          prefs.setString('PNoti', str);
        });
      }
      await prefs.setBool('firstProduct', false);
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: i,
            channelKey: 'product_channel',
            title:
                '${Emojis.food_honey_pot} ${AppLocalizations.of(context)!.product}',
            body: '${prefs.getString('PNoti')}',
            summary: AppLocalizations.of(context)!.afiyahReminder,
            wakeUpScreen: true,
            category: NotificationCategory.Reminder,
            autoDismissible: false,
            notificationLayout: NotificationLayout.BigText,
          ),
          actionButtons: [
            NotificationActionButton(
                key: "ARCHIVE",
                label: locale.skipNotification!,
                autoDismissible: true,
                color: const Color(0xffbe6e29),
                buttonType: ActionButtonType.Default),
            NotificationActionButton(
                key: "TAKE",
                label: locale.markAsDone!,
                color: const Color(0xffbe6e29),
                buttonType: ActionButtonType.Default),
            NotificationActionButton(
                key: 'SNOOZE',
                label: locale.snooze!,
                color: const Color(0xffbe6e29),
                autoDismissible: true)
          ],
          schedule: NotificationCalendar.fromDate(
            preciseAlarm: true,
            allowWhileIdle: true,
            repeats: true,
            date: time,
          ));
    }
  }

  Future<void> createSadaqahReminderNotification(DateTime d) async {
    var locale = AppLocalizations.of(context)!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('sedekah')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (mounted) {
          setState(() {
            if (AppLocalizations.of(context)!.language != 'Language') {
              if (doc['terjemahanHadith'] != '' &&
                  doc['terjemahanHadith'].length < 400) {
                _sedekah.add(
                    '${doc['terjemahanHadith']} (${doc['kitabDanNomborHadith']}) ');
              } else {
                if (doc['terjemahanQuran'] != '' &&
                    doc['terjemahanQuran'].length < 400) {
                  _sedekah.add(
                      '${doc['terjemahanQuran']} (${doc['surahDanAyat']}) ');
                }
              }
            } else if (AppLocalizations.of(context)!.language == 'Language') {
              if (doc['translation_hadith'] != '' &&
                  doc['translation_hadith'].length < 400) {
                _sedekah.add(
                    '${doc['translation_hadith']} (${doc['kitabDanNomborHadith']}) ');
              } else {
                if (doc['translation_quran'] != '' &&
                    doc['translation_quran'].length < 400) {
                  _sedekah.add(
                      '${doc['translation_quran']} (${doc['surahDanAyat']}) ');
                }
              }
            }
          });
        }
      }
    });
    for (int i = 0; i < 30; i++) {
      var time = DateTime(
          d.year, d.month, d.day + i, d.hour, d.minute, d.second, 0, 0);
      if (mounted) {
        setState(() {
          Random random = Random();
          numbS = random.nextInt(_sedekah.length);
          var str = _sedekah[numbS]
              .trim()
              .replaceAll('�', '')
              .replaceAll('(?)', '')
              .replaceAll('?\n', '')
              .replaceAll('Rasulullah ?', 'Rasulullah');
          prefs.setString('SNoti', str);
        });
      }
      await prefs.setBool('firstSadaqah', false);
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: i + 30,
            channelKey: 'sadaqah_channel',
            title:
                '${Emojis.money_coin} ${AppLocalizations.of(context)!.sedekah}',
            body: prefs.getString('SNoti'),
            summary: AppLocalizations.of(context)!.sadaqahReminder,
            wakeUpScreen: true,
            category: NotificationCategory.Reminder,
            autoDismissible: false,
            notificationLayout: NotificationLayout.BigText,
          ),
          actionButtons: [
            NotificationActionButton(
                key: "ARCHIVE",
                label: locale.skipNotification!,
                autoDismissible: true,
                color: const Color(0xffbe6e29),
                buttonType: ActionButtonType.Default),
            NotificationActionButton(
                key: "TAKE",
                label: locale.markAsDone!,
                color: const Color(0xffbe6e29),
                buttonType: ActionButtonType.Default),
            NotificationActionButton(
                key: 'SNOOZE',
                label: locale.snooze!,
                color: const Color(0xffbe6e29),
                autoDismissible: true)
          ],
          schedule: NotificationCalendar.fromDate(
            preciseAlarm: true,
            allowWhileIdle: true,
            date: time,
            repeats: false,
          ));
    }
  }

  Future<void> createTahajjudReminderNotification(DateTime d) async {
    var locale = AppLocalizations.of(context)!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('tahajjud')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (mounted) {
          setState(() {
            if (AppLocalizations.of(context)!.language != 'Language') {
              if (doc['terjemahanHadith'] != '' &&
                  doc['terjemahanHadith'].length < 400) {
                _tahajjud.add(
                    '${doc['terjemahanHadith']} (${doc['kitabDanNomborHadith']}) ');
              } else {
                if (doc['terjemahanQuran'] != '' &&
                    doc['terjemahanQuran'].length < 400) {
                  _tahajjud.add(
                      '${doc['terjemahanQuran']} (${doc['surahDanAyat']}) ');
                }
              }
            } else if (AppLocalizations.of(context)!.language == 'Language') {
              if (doc['translation_hadith'] != '' &&
                  doc['translation_hadith'].length < 400) {
                _tahajjud.add(
                    '${doc['translation_hadith']} (${doc['kitabDanNomborHadith']}) ');
              } else {
                if (doc['translation_quran'] != '' &&
                    doc['translation_quran'].length < 400) {
                  _tahajjud.add(
                      '${doc['translation_quran']} (${doc['surahDanAyat']}) ');
                }
              }
            }
          });
        }
      }
    });
    for (int i = 0; i < 30; i++) {
      var time = DateTime(
          d.year, d.month, d.day + i, d.hour, d.minute, d.second, 0, 0);
      if (mounted) {
        setState(() {
          Random random = Random();
          numbT = random.nextInt(_tahajjud.length);
          var str = _tahajjud[numbT]
              .trim()
              .replaceAll('�', '')
              .replaceAll('(?)', '')
              .replaceAll('?\n', '')
              .replaceAll('Rasulullah ?', 'Rasulullah');
          prefs.setString('TNoti', str);
        });
      }

      await prefs.setBool('firstTahajjud', false);
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: i + 60,
            channelKey: 'tahajjud_channel',
            title:
                '${Emojis.building_mosque} ${AppLocalizations.of(context)!.tahajjud}',
            body: prefs.getString('TNoti'),
            summary: AppLocalizations.of(context)!.tahajjudReminder,
            wakeUpScreen: true,
            category: NotificationCategory.Reminder,
            autoDismissible: false,
            notificationLayout: NotificationLayout.BigText,
          ),
          actionButtons: [
            NotificationActionButton(
                key: "ARCHIVE",
                label: locale.skipNotification!,
                autoDismissible: true,
                color: const Color(0xffbe6e29),
                buttonType: ActionButtonType.Default),
            NotificationActionButton(
                key: "TAKE",
                label: locale.markAsDone!,
                color: const Color(0xffbe6e29),
                buttonType: ActionButtonType.Default),
            NotificationActionButton(
                key: 'SNOOZE',
                label: locale.snooze!,
                color: const Color(0xffbe6e29),
                autoDismissible: true)
          ],
          schedule: NotificationCalendar.fromDate(
            preciseAlarm: true,
            allowWhileIdle: true,
            date: time,
            repeats: false,
          ));
    }
  }

  _selectTimes(BuildContext context, DateTime date, String document,
      {int? intake}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime schedule;
    var locale = AppLocalizations.of(context)!;
    var newTime =
        DateTime(date.year, date.month, date.day, date.hour, date.minute + 2);
    BottomPicker.time(
            pickerTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
            initialDateTime: newTime,
            title: locale.setNotificationTime!,
            titleStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: ManyColors.textColor1),
            onSubmit: (index) {
              schedule = index;
              if (schedule != date) {
                var w = document.substring(0, 5);
                var m = document.substring(0, document.length - 1);
                setState(() {
                  final now = DateTime.now();
                  final difference = schedule.difference(now).inSeconds;
                  final dif = schedule.difference(now);
                  duration = difference;
                  String da = dif.toString();
                  var hours = da.substring(0, 1);
                  var minutes = da.substring(2, 4);
                  var seconds = da.substring(5, 7);
                  if (hours == '0') {
                    hours = '';
                  } else {
                    hours = '$hours hours, ';
                  }
                  if (minutes == '00') {
                    minutes = '';
                  } else {
                    minutes = '$minutes minutes, ';
                  }
                  if (seconds == '00') {
                    seconds = '';
                  } else {
                    seconds = '$seconds seconds ';
                  }
                  Fluttertoast.showToast(
                      msg: '$hours$minutes${seconds}time remaining');
                  print('waiting for $duration s');
                  if (document == 'product') {
                    prefs.setBool('P${AppUser.instance.user!.uid}', true);
                    a = DateFormat.jm().format(schedule);
                    createProductReminderNotification(schedule);
                    String? id = AppUser.instance.user!.uid;
                    DocumentReference users = FirebaseFirestore.instance
                        .collection('users')
                        .doc(id)
                        .collection("schedule")
                        .doc(document);
                    users
                        .set({"time": schedule})
                        .then((value) => print("schedule save"))
                        .catchError(
                            (error) => print("Failed to merge data: $error"));
                  }
                  if (document == 'sadaqah') {
                    prefs.setBool('S${AppUser.instance.user!.uid}', true);
                    c = DateFormat.jm().format(schedule);
                    createSadaqahReminderNotification(schedule);
                    String? id = AppUser.instance.user!.uid;
                    DocumentReference users = FirebaseFirestore.instance
                        .collection('users')
                        .doc(id)
                        .collection("schedule")
                        .doc(document);
                    users
                        .set({"time": schedule})
                        .then((value) => print("schedule save"))
                        .catchError(
                            (error) => print("Failed to merge data: $error"));
                  }
                  if (document == 'tahajjud') {
                    prefs.setBool('T${AppUser.instance.user!.uid}', true);
                    setState(() {
                      isSwitched4 = true;
                    });
                    d = DateFormat.jm().format(schedule);
                    createTahajjudReminderNotification(schedule);
                    String? id = AppUser.instance.user!.uid;
                    DocumentReference users = FirebaseFirestore.instance
                        .collection('users')
                        .doc(id)
                        .collection("schedule")
                        .doc(document);
                    users
                        .set({"time": schedule})
                        .then((value) => print("schedule save"))
                        .catchError(
                            (error) => print("Failed to merge data: $error"));
                  }
                });
              }
            },
            onClose: () {
              print('close');
              if (a == '') {
                setState(() {
                  isSwitched = false;
                  close('isSwitched');
                });
              }
              if (e == '') {
                setState(() {
                  isSwitched2 = false;
                  close('isSwitched2');
                });
              }
              if (c == '') {
                setState(() {
                  isSwitched3 = false;
                  close('isSwitched3');
                });
              }
              if (d == '') {
                setState(() {
                  isSwitched4 = false;
                  close('isSwitched4');
                });
              }
            },
            bottomPickerTheme: BOTTOM_PICKER_THEME.orange,
            use24hFormat: false)
        .show(context);
  }

  Future<void> checkTime() => _memoizer.runOnce(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var hasProduct =
            prefs.getBool('P${AppUser.instance.user!.uid}') ?? false;
        var hasSadaqah =
            prefs.getBool('S${AppUser.instance.user!.uid}') ?? false;
        var hasTahajjud =
            prefs.getBool('T${AppUser.instance.user!.uid}') ?? false;
        var hasWater = prefs.getBool('W${AppUser.instance.user!.uid}') ?? false;
        var hasMedicine1 =
            prefs.getBool('m1${AppUser.instance.user!.uid}') ?? false;
        var hasMedicine2 =
            prefs.getBool('m2${AppUser.instance.user!.uid}') ?? false;
        if (hasProduct == true) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          firestore
              .collection('users')
              .doc(AppUser.instance.user!.uid)
              .collection("schedule")
              .doc("product")
              .get()
              .then((value) {
            Timestamp myTimeStamp = value["time"];

            DateTime myDateTime = myTimeStamp.toDate();
            if (mounted) {
              setState(() {
                a = DateFormat.jm().format(myDateTime);
              });
            }
            DateTime now = DateTime.now();
            DateTime schedule = DateTime(now.year, now.month, now.day,
                myDateTime.hour, myDateTime.minute);
            if (myDateTime.difference(now).inMicroseconds > 0) {
              createProductReminderNotification(schedule);
            } else {
              var date = DateTime(schedule.year, schedule.month,
                  schedule.day + 1, schedule.hour, schedule.minute, 0);
              createProductReminderNotification(date);
            }
          });
        } else {
          if (mounted) {
            setState(() {
              a = '9:00 AM';
            });
          }
          DateTime now = DateTime.now();
          DateTime schedule = DateTime(now.year, now.month, now.day, 9, 0);
          String? id = AppUser.instance.user!.uid;

          CollectionReference users = FirebaseFirestore.instance
              .collection('users')
              .doc(id)
              .collection("schedule");

          users.doc('product')
              // existing document in 'users' collection: "ABC123"
              .set(
            {
              'time': schedule,
            },
          ).then((value) {
            if (schedule.difference(now).inMicroseconds > 0) {
              createProductReminderNotification(schedule);
            } else {
              var date = DateTime(schedule.year, schedule.month,
                  schedule.day + 1, schedule.hour, schedule.minute, 0);
              createProductReminderNotification(date);
            }
          }).catchError((error) => print("Failed to merge data: $error"));
        }
        if (hasSadaqah == true) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          firestore
              .collection('users')
              .doc(AppUser.instance.user!.uid)
              .collection("schedule")
              .doc("sadaqah")
              .get()
              .then((value) {
            Timestamp myTimeStamp = value["time"];
            DateTime myDateTime = myTimeStamp.toDate();
            if (mounted) {
              setState(() {
                c = DateFormat.jm().format(myDateTime);
              });
            }

            DateTime now = DateTime.now();
            DateTime schedule = DateTime(now.year, now.month, now.day,
                myDateTime.hour, myDateTime.minute);
            if (myDateTime.difference(now).inMicroseconds > 0) {
              createSadaqahReminderNotification(schedule);
            } else {
              var date = DateTime(schedule.year, schedule.month,
                  schedule.day + 1, schedule.hour, schedule.minute, 0);
              createSadaqahReminderNotification(date);
            }
          });
        }
        if (hasTahajjud == true) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          await firestore
              .collection('users')
              .doc(AppUser.instance.user!.uid)
              .collection("schedule")
              .doc("tahajjud")
              .get()
              .then((value) {
            Timestamp myTimeStamp = value["time"];
            DateTime myDateTime = myTimeStamp.toDate();
            setState(() {
              d = DateFormat.jm().format(myDateTime);
            });
            DateTime now = DateTime.now();
            DateTime schedule = DateTime(now.year, now.month, now.day,
                myDateTime.hour, myDateTime.minute);
            if (myDateTime.difference(now).inMicroseconds > 0) {
              createTahajjudReminderNotification(schedule);
            } else {
              var date = DateTime(schedule.year, schedule.month,
                  schedule.day + 1, schedule.hour, schedule.minute, 0);
              createTahajjudReminderNotification(date);
            }
          });
        }
        if (hasWater == true) {
          await Provider.of<WaterProvider>(context, listen: false).getTime();
        }
        if (hasMedicine1 == true) {
          await Provider.of<Medicine1Provider>(context, listen: false)
              .getTime();
        }
        if (hasMedicine2 == true) {}
      });

  Future<void> checkWaterIntake() async {
    var age = 0;
    var weight = 0.0;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .get()
        .then((value) {
      String year = value["date of birth"].substring(6, 10);
      var now = DateTime.now();
      age = now.year - int.parse(year);
      weight = double.parse(value["weight"]);
      userData.weight = value["weight"] ?? '';
      if (age > 65) {
        setState(() {
          b = '${(25 * weight) / 1000}';
          waterPerday = (25 * weight) ~/ 250;
          Provider.of<WaterProvider>(context, listen: false)
              .getWaterIntake(waterPerday);
        });
      } else if (age > 30) {
        setState(() {
          b = '${(30 * weight) / 1000}';
          waterPerday = (30 * weight) ~/ 250;
          Provider.of<WaterProvider>(context, listen: false)
              .getWaterIntake(waterPerday);
        });
      } else {
        setState(() {
          b = '${(35 * weight) / 1000}';
          waterPerday = (35 * weight) ~/ 250;
          Provider.of<WaterProvider>(context, listen: false)
              .getWaterIntake(waterPerday);
        });
      }
    }).catchError((e) {
      if (mounted) {
        setState(() {
          userData.weight = '$e';
        });
      }
    });
    if (waterLoad == false) {
      Provider.of<WaterProvider>(context, listen: false)
          .getHadisAndQuranVerse(code);
    }
    if (med1Load == false) {
      Provider.of<Medicine1Provider>(context, listen: false)
          .getHadisAndQuranVerse(code);
    }
    if (med2Load == false) {
      Provider.of<Medicine2Provider>(context, listen: false)
          .getHadisAndQuranVerse(code);
    }
    Provider.of<WaterProvider>(context, listen: false).getSchedule();
    Provider.of<Medicine2Provider>(context, listen: false).getSchedule();
    Provider.of<Medicine1Provider>(context, listen: false).getSchedule();
  }

  Future<void> checkMedicine() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var hasMedicine =
        (prefs.getBool('M${AppUser.instance.user!.uid}') ?? false);
    setState(() {
      isSwitched5 = hasMedicine;
    });
  }

  void close(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (a == 'isSwitched') {
      await prefs.setBool('P${AppUser.instance.user!.uid}', false);
    } else if (a == 'isSwitched2') {
      await prefs.setBool('W${AppUser.instance.user!.uid}', false);
    } else if (a == 'isSwitched3') {
      await prefs.setBool('S${AppUser.instance.user!.uid}', false);
    } else if (a == 'isSwitched4') {
      await prefs.setBool('T${AppUser.instance.user!.uid}', false);
    }
  }

  Future<void> getTime(String type) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .collection("schedule")
        .doc(type)
        .get()
        .then((value) {
      Timestamp myTimeStamp = value["time"];
      DateTime myDateTime = myTimeStamp.toDate();
      setState(() {
        if (type == 'tahajjud') {
          d = DateFormat.jm().format(myDateTime);
        }
        if (type == 'sadaqah') {
          c = DateFormat.jm().format(myDateTime);
        }
        if (type == 'medicine2') {
          f = DateFormat.jm().format(myDateTime);
        }
      });
      DateTime now = DateTime.now();
      DateTime schedule = DateTime(
          now.year, now.month, now.day, myDateTime.hour, myDateTime.minute);
      if (myDateTime.difference(now).inMicroseconds > 0) {
        if (type == 'tahajjud') {
          createTahajjudReminderNotification(schedule);
        }
        if (type == 'sadaqah') {
          createSadaqahReminderNotification(schedule);
        }
      }
      if (myDateTime.difference(now).inMicroseconds < 0) {
        var date = DateTime(schedule.year, schedule.month, schedule.day + 1,
            schedule.hour, schedule.minute, 0);
        if (type == 'tahajjud') {
          createTahajjudReminderNotification(date);
        }
        if (type == 'sadaqah') {
          createSadaqahReminderNotification(date);
        }
      }
    });

    if (type == 'medicine1') {
      Provider.of<Medicine1Provider>(context, listen: false).getTime();
    }
    if (type == 'medicine2') {
      Provider.of<Medicine2Provider>(context, listen: false).getTime();
    }
  }

  void back() {
    setState(() {
      med2 = !med2;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double appbarSize = AppBar().preferredSize.height;
    var statusbar = MediaQuery.of(context).viewPadding.top;
    var locale = AppLocalizations.of(context)!;
    var name1 = locale.medicineNo1!;

    Future<bool> showExitPopup() async {
      return await showDialog(
        //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text(locale.exitApp!),
          content: Text(locale.confirmExitApp!),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child: Text(locale.no!),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                if (Platform.isAndroid) {
                  SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop');
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },

              //return true when click on "Yes"
              child: Text(locale.yes!),
            ),
          ],
        ),
      ) ??
          false; //if showDialogue had returned null, then return false
    }

    return WillPopScope(
      onWillPop: () async => showExitPopup(),
      child: Scaffold(
        drawer: const NavigationDrawer(), //TODO: OPEN DRAWER
        extendBodyBehindAppBar: true,
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          // automaticallyImplyLeading: true,
          leading: Container(),
        ),
        body: FutureBuilder(
          future: countUnReadDocuments(),
          builder: (context, AsyncSnapshot snapshot) {
            return Container(
              padding: EdgeInsets.only(top: statusbar),
              child: Stack(
                children: [
                  SizedBox(
                    height: height * .2 + (appbarSize),
                    width: width,
                    // color: kPrimaryColor,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'assets/masjid.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                      child: Container(
                          padding: EdgeInsets.only(top: appbarSize),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          width: 75,
                                          height: 75,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const NavigationDrawer()),
                                              );
                                            },
                                            child: ClipOval(
                                              child: SizedBox.fromSize(
                                                size: const Size.fromRadius(48),
                                                child: Image.network(
                                                    AppUser.instance.user!
                                                            .photoURL ??
                                                        'https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg',
                                                    width: 50,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                AppUser.instance.user!
                                                        .displayName ??
                                                    '',
                                                style:
                                                    boldTextStyle(color: black)),
                                            4.height,
                                            Text(locale.welcome_home!,
                                                style: secondaryTextStyle(
                                                    color:
                                                        black.withOpacity(0.7))),
                                          ],
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NotificationPage(2)),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.message,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                _list.length > 300
                                    ? CardBody(
                                        radius: BorderRadius.circular(16),
                                        child: Container(
                                          height: height * .3,
                                          width: width,
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ListTile(
                                                  minVerticalPadding: 16,
                                                  title: Text(
                                                    locale.ofTheDay!,
                                                    textAlign: TextAlign.center,
                                                    style: textStyleNormal,
                                                  ),
                                                  subtitle: Text(
                                                    _list[DateTime.now().month *
                                                            DateTime.now().day]
                                                        .trim()
                                                        .replaceAll('�', '')
                                                        .replaceAll('(?)', '')
                                                        .replaceAll('?\n', '')
                                                        .replaceAll(
                                                            'Rasulullah ?',
                                                            'Rasulullah'),
                                                    style: textStyleNormal,
                                                    textAlign: TextAlign.justify,
                                                  )),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const AllHadis()));
                                                        },
                                                        child: const Text(
                                                            'More Collection',
                                                            style:
                                                                textStyleNormalGrey),
                                                        // Icon(
                                                        //   Icons.arrow_forward_ios,
                                                        //   size: 15,
                                                        //   color: Colors.grey,
                                                        // )
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                        child: const Card(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          elevation: 8,
                                          color: white,
                                          child: ListTile(
                                              minVerticalPadding: 16,
                                              title: Text('loading..')),
                                        ),
                                      ),
                                Container(
                                    width: width,
                                    margin: const EdgeInsets.only(top: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(locale.reminder!,
                                            style: textStyleBold),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DefaultCircleCard(
                                              icon: const ImageIcon(
                                                AssetImage(
                                                  'assets/honey.png',
                                                ),
                                                size: 60,
                                                // color: Color(0xFF3A5A98),
                                              ),
                                              label: locale.HH!,
                                              onPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DefaultDialog(
                                                    body: StatefulBuilder(builder:
                                                        (context, setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Card(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            elevation: 8,
                                                            color: white,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                  leading: !visible
                                                                      ? const Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_outlined)
                                                                      : const Icon(
                                                                          Icons
                                                                              .keyboard_arrow_up_outlined),
                                                                  title: Text(
                                                                    locale
                                                                        .afiyahReminder!,
                                                                    style: const TextStyle(
                                                                        color:
                                                                            black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold),
                                                                  ),
                                                                  subtitle: Text(
                                                                    locale.HH!,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                                .grey[
                                                                            800],
                                                                        fontSize:
                                                                            14),
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible:
                                                                      visible,
                                                                  child: Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                                .all(
                                                                            16.0),
                                                                    child:
                                                                        RichText(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                      text: TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                                text: locale.text1!, //afiyah des
                                                                                style: const TextStyle(color: Colors.black)),
                                                                            TextSpan(
                                                                                recognizer: TapGestureRecognizer()..onTap = () => launch('http://as-sunnah.com/'),
                                                                                text: locale.text2!,
                                                                                style: const TextStyle(color: Colors.blueAccent)),
                                                                            TextSpan(
                                                                                text: locale.text3!,
                                                                                style: const TextStyle(color: Colors.black)),
                                                                          ]),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible:
                                                                      visible,
                                                                  child:
                                                                      ButtonBar(
                                                                    alignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          CoolAlert.show(
                                                                              onCancelBtnTap: () => Navigator.pop(context),
                                                                              title: locale.afiyahReminder!,
                                                                              onConfirmBtnTap: () {
                                                                                Navigator.pop(context);
                                                                                _selectTimes(context, DateTime.now(), 'product');
                                                                              },
                                                                              context: context,
                                                                              type: CoolAlertType.info,
                                                                              text: hadis ? locale.sQuranP : locale.sHadithP,
                                                                              showCancelBtn: true,
                                                                              cancelBtnText: locale.back!,
                                                                              confirmBtnText: locale.selectTime!);
                                                                          setState(
                                                                              () {
                                                                            hadis =
                                                                                !hadis;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          locale
                                                                              .view!,
                                                                          style: const TextStyle(
                                                                              fontWeight:
                                                                                  FontWeight.bold,
                                                                              color: Colors.black),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                            ),
                                            DefaultCircleCard(
                                              icon: const ImageIcon(
                                                AssetImage(
                                                  'assets/tahajjud.png',
                                                ),
                                                size: 60,
                                                // color: Color(0xFF3A5A98),
                                              ),
                                              label: 'Tahajjud',
                                              onPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DefaultDialog(
                                                    body: StatefulBuilder(builder:
                                                        (context, setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Card(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            elevation: 8,
                                                            color: white,
                                                            child: ExpansionTile(
                                                              leading: const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined),
                                                              title: Text(
                                                                locale
                                                                    .tahajjudReminder!,
                                                                style: const TextStyle(
                                                                    color: black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              subtitle: (d != '')
                                                                  ? Text(
                                                                      '${locale.timeReminder!} $d',
                                                                      style: const TextStyle(
                                                                          color:
                                                                              black),
                                                                    )
                                                                  : Text(
                                                                      '${locale.timeReminder!} N/A',
                                                                      style: const TextStyle(
                                                                          color:
                                                                              black),
                                                                    ),
                                                              trailing: Switch(
                                                                value:
                                                                    isSwitched4,
                                                                onChanged:
                                                                    (value) async {
                                                                  SharedPreferences
                                                                      prefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  await prefs.setBool(
                                                                      'T${AppUser.instance.user!.uid}',
                                                                      value);

                                                                  firstTimeTahajjud =
                                                                      prefs.getBool(
                                                                              'firstTahajjud') ??
                                                                          true;
                                                                  setState(() {
                                                                    isSwitched4 =
                                                                        value;
                                                                  });

                                                                  if (isSwitched4 ==
                                                                      true) {
                                                                    if (firstTimeTahajjud ==
                                                                        true) {
                                                                      SharedPreferences
                                                                          prefs =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      CoolAlert.show(
                                                                          onCancelBtnTap: () async {
                                                                            Navigator.pop(
                                                                                context);
                                                                            await SharedPreferences
                                                                                .getInstance();
                                                                            await prefs.setBool(
                                                                                'T${AppUser.instance.user!.uid}',
                                                                                false);
                                                                            setState(
                                                                                () {
                                                                              isSwitched4 =
                                                                                  false;
                                                                            });
                                                                          },
                                                                          title: locale.tahajjudReminder!,
                                                                          onConfirmBtnTap: () {
                                                                            Navigator.pop(
                                                                                context);
                                                                            _selectTimes(
                                                                                context,
                                                                                DateTime.now(),
                                                                                'tahajjud');
                                                                          },
                                                                          context: context,
                                                                          type: CoolAlertType.info,
                                                                          text: hadis ? locale.strongHadisT : locale.strongQuranT,
                                                                          showCancelBtn: true,
                                                                          cancelBtnText: locale.back!,
                                                                          confirmBtnText: locale.selectTime!);
                                                                      hadis =
                                                                          !hadis;
                                                                    } else {
                                                                      getTime(
                                                                          'tahajjud');
                                                                    }
                                                                  }
                                                                  if (isSwitched4 ==
                                                                      false) {
                                                                    Provider.of<CancelNotificationProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .cancel(
                                                                            'tahajjud');
                                                                  }
                                                                },
                                                                activeColor:
                                                                    kPrimaryColor,
                                                                inactiveThumbColor:
                                                                    Colors.white,
                                                              ),
                                                              children: <Widget>[
                                                                ListTile(
                                                                  title: Tooltip(
                                                                    message: locale
                                                                        .tooltipEdit!,
                                                                    child:
                                                                        TextButton(
                                                                      style: TextButton.styleFrom(
                                                                          backgroundColor:
                                                                              kPrimaryColor),
                                                                      onPressed:
                                                                          () async {
                                                                        CoolAlert.show(
                                                                            onCancelBtnTap: () => Navigator.pop(context),
                                                                            title: locale.tahajjudReminder!,
                                                                            onConfirmBtnTap: () {
                                                                              Navigator.pop(context);
                                                                              _selectTimes(
                                                                                  context,
                                                                                  DateTime.now(),
                                                                                  'tahajjud');
                                                                            },
                                                                            context: context,
                                                                            type: CoolAlertType.info,
                                                                            text: hadis ? locale.strongHadisT : locale.strongQuranT,
                                                                            showCancelBtn: true,
                                                                            cancelBtnText: locale.back!,
                                                                            confirmBtnText: locale.selectTime!);
                                                                        hadis =
                                                                            !hadis;
                                                                      },
                                                                      child: Text(
                                                                        locale
                                                                            .view!,
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Colors.black),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                            ),
                                            DefaultCircleCard(
                                              icon: const ImageIcon(
                                                AssetImage(
                                                  'assets/water.png',
                                                ),
                                                size: 60,
                                                // color: Color(0xFF3A5A98),
                                              ),
                                              label: 'Water',
                                              onPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DefaultDialog(
                                                    body: Consumer<WaterProvider>(
                                                        builder: (context, water,
                                                            child) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Card(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            elevation: 8,
                                                            color: white,
                                                            child: ExpansionTile(
                                                              leading: const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined),
                                                              title: Text(
                                                                locale
                                                                    .waterReminder!,
                                                                style: const TextStyle(
                                                                    color: black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              subtitle: Text(
                                                                '$waterPerday ${locale.glassOfWater!} ($bℓ)',
                                                                style:
                                                                    const TextStyle(
                                                                        color:
                                                                            black),
                                                              ),
                                                              trailing: Switch(
                                                                value:
                                                                    isSwitched2,
                                                                onChanged:
                                                                    (value) async {
                                                                  if (waterPerday !=
                                                                      0) {
                                                                    SharedPreferences
                                                                        prefs =
                                                                        await SharedPreferences
                                                                            .getInstance();
                                                                    await prefs
                                                                        .setBool(
                                                                            'W${AppUser.instance.user!.uid}',
                                                                            value);
                                                                    firstTimeWater =
                                                                        prefs.getBool(
                                                                                'firstWater') ??
                                                                            true;
                                                                    setState(() {
                                                                      isSwitched2 =
                                                                          value;
                                                                    });

                                                                    if (isSwitched2 ==
                                                                        true) {
                                                                      bool h =
                                                                          await showDialog(
                                                                        barrierDismissible:
                                                                            false,
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return MyDialog(
                                                                              waterPerday);
                                                                        },
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        isSwitched2 =
                                                                            h;
                                                                        prefs.setBool(
                                                                            'W${AppUser.instance.user!.uid}',
                                                                            h);
                                                                      });
                                                                      checkTime();
                                                                    }
                                                                    if (isSwitched2 ==
                                                                        false) {
                                                                      water
                                                                          .cancelNotifications();
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg:
                                                                                  locale.cancelWaterReminder!);
                                                                    }
                                                                  } else {
                                                                    showDialog(
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text(locale.back!)),
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfile()));
                                                                                  },
                                                                                  child: Text(locale.update_profile!))
                                                                            ],
                                                                            title:
                                                                                Text(locale.beforeWaterReminder!),
                                                                          );
                                                                        },
                                                                        context:
                                                                            context);
                                                                  }
                                                                },
                                                                activeColor:
                                                                    Colors.blue[
                                                                        400],
                                                                inactiveThumbColor:
                                                                    Colors.white,
                                                              ),
                                                              children: [
                                                                ListTile(
                                                                  title:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () async {
                                                                      if (waterPerday !=
                                                                          0) {
                                                                        SharedPreferences
                                                                            prefs =
                                                                            await SharedPreferences
                                                                                .getInstance();
                                                                        bool h =
                                                                            await showDialog(
                                                                          barrierDismissible:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext
                                                                                  context) {
                                                                            return MyDialog(
                                                                              waterPerday,
                                                                            );
                                                                          },
                                                                        );
                                                                        setState(
                                                                            () {
                                                                          isSwitched2 =
                                                                              h;
                                                                          prefs.setBool(
                                                                              'W${AppUser.instance.user!.uid}',
                                                                              h);
                                                                        });
                                                                      } else {
                                                                        showDialog(
                                                                            builder: (BuildContext
                                                                                context) {
                                                                              return AlertDialog(
                                                                                actions: [
                                                                                  TextButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text(locale.back!)),
                                                                                  TextButton(
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfile()));
                                                                                      },
                                                                                      child: Text(locale.update_profile!))
                                                                                ],
                                                                                title: Text(locale.beforeWaterReminder!),
                                                                              );
                                                                            },
                                                                            context:
                                                                                context);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      locale
                                                                          .showAllReminder!,
                                                                      style: const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                    style: TextButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .blueAccent),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DefaultCircleCard(
                                              icon: const ImageIcon(
                                                AssetImage(
                                                  'assets/sadaqahh.png',
                                                ),
                                                size: 60,
                                                // color: Color(0xFF3A5A98),
                                              ),
                                              label: 'Sadaqah',
                                              onPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DefaultDialog(
                                                    body: StatefulBuilder(builder:
                                                        (context, setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Card(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            elevation: 8,
                                                            color: white,
                                                            child: ExpansionTile(
                                                              leading: const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined),
                                                              title: Text(
                                                                locale
                                                                    .sadaqahReminder!,
                                                                style: const TextStyle(
                                                                    color: black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              subtitle: (c != '')
                                                                  ? Text(
                                                                      '${locale.timeReminder!} $c',
                                                                      style: const TextStyle(
                                                                          color:
                                                                              black),
                                                                    )
                                                                  : Text(
                                                                      '${locale.timeReminder!} N/A',
                                                                      style: const TextStyle(
                                                                          color:
                                                                              black),
                                                                    ),
                                                              trailing: Switch(
                                                                value:
                                                                    isSwitched3,
                                                                onChanged:
                                                                    (value) async {
                                                                  SharedPreferences
                                                                      prefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  await prefs.setBool(
                                                                      'S${AppUser.instance.user!.uid}',
                                                                      value);
                                                                  firstTimeSadaqah =
                                                                      prefs.getBool(
                                                                              'firstSadaqah') ??
                                                                          true;
                                                                  setState(() {
                                                                    isSwitched3 =
                                                                        value;
                                                                  });

                                                                  if (isSwitched3 ==
                                                                      true) {
                                                                    if (firstTimeSadaqah ==
                                                                        true) {
                                                                      SharedPreferences
                                                                          prefs =
                                                                          await SharedPreferences
                                                                              .getInstance();
                                                                      CoolAlert.show(
                                                                          title: locale.sadaqahReminder!,
                                                                          onCancelBtnTap: () async {
                                                                            Navigator.pop(
                                                                                context);
                                                                            await SharedPreferences
                                                                                .getInstance();
                                                                            await prefs.setBool(
                                                                                'S${AppUser.instance.user!.uid}',
                                                                                false);
                                                                            setState(
                                                                                () {
                                                                              isSwitched3 =
                                                                                  false;
                                                                            });
                                                                          },
                                                                          onConfirmBtnTap: () {
                                                                            Navigator.pop(
                                                                                context);
                                                                            _selectTimes(
                                                                                context,
                                                                                DateTime.now(),
                                                                                'sadaqah');
                                                                          },
                                                                          context: context,
                                                                          type: CoolAlertType.info,
                                                                          text: hadis ? locale.strongHadisS : locale.strongQuranS,
                                                                          showCancelBtn: true,
                                                                          cancelBtnText: locale.back!,
                                                                          confirmBtnText: locale.selectTime!);
                                                                      hadis =
                                                                          !hadis;
                                                                    } else {
                                                                      getTime(
                                                                          'sadaqah');
                                                                    }
                                                                  }
                                                                  if (isSwitched3 ==
                                                                      false) {
                                                                    Provider.of<CancelNotificationProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .cancel(
                                                                            'sadaqah');
                                                                  }
                                                                },
                                                                activeColor:
                                                                    Colors.blue[
                                                                        400],
                                                                inactiveThumbColor:
                                                                    Colors.white,
                                                              ),
                                                              children: <Widget>[
                                                                ListTile(
                                                                  title: Tooltip(
                                                                    message: locale
                                                                        .tooltipEdit!,
                                                                    child:
                                                                        TextButton(
                                                                      style: TextButton.styleFrom(
                                                                          backgroundColor:
                                                                              Colors.blueAccent),
                                                                      onPressed:
                                                                          () async {
                                                                        CoolAlert.show(
                                                                            onCancelBtnTap: () => Navigator.pop(context),
                                                                            title: locale.sadaqahReminder!,
                                                                            onConfirmBtnTap: () {
                                                                              Navigator.pop(context);
                                                                              _selectTimes(
                                                                                  context,
                                                                                  DateTime.now(),
                                                                                  'sadaqah');
                                                                            },
                                                                            context: context,
                                                                            type: CoolAlertType.info,
                                                                            text: hadis ? locale.strongHadisS : locale.strongQuranS,
                                                                            showCancelBtn: true,
                                                                            cancelBtnText: locale.back!,
                                                                            confirmBtnText: locale.selectTime!);
                                                                        hadis =
                                                                            !hadis;
                                                                      },
                                                                      child: Text(
                                                                        locale
                                                                            .view!,
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          20.height,
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    DefaultButton(
                                                                  onPress: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              DefaultDialog(
                                                                        body: StatefulBuilder(builder:
                                                                            (context,
                                                                                setState) {
                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              dialogBody('Coming Soon'),
                                                                              dialogButton(
                                                                                'Close',
                                                                                ' ',
                                                                                () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                              )
                                                                            ],
                                                                          );
                                                                        }),
                                                                      ),
                                                                    );
                                                                    // Navigator.push(
                                                                    //   context,
                                                                    //   MaterialPageRoute(
                                                                    //       builder:
                                                                    //           (context) =>
                                                                    //               const SadaqahPage()),
                                                                    // );
                                                                  },
                                                                  label:
                                                                      'Sadaqah Now',
                                                                  textStyle:
                                                                      textStyleNormal,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16)),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 15,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 100,
                                                            height: 50,
                                                            child: DefaultButton(
                                                              onPress: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              label: 'Back',
                                                              textStyle:
                                                                  textStyleNormalGrey,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16)),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                            ),
                                            DefaultCircleCard(
                                              icon: const ImageIcon(
                                                AssetImage(
                                                  'assets/medicine.png',
                                                ),
                                                size: 60,
                                                // color: Color(0xFF3A5A98),
                                              ),
                                              label: 'Medicine',
                                              onPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DefaultDialog(
                                                    body: Consumer<
                                                            Medicine1Provider>(
                                                        builder: (context,
                                                            medicine1, child) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Card(
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            elevation: 8,
                                                            color: white,
                                                            child: ExpansionTile(
                                                              leading: const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined),
                                                              title: locale
                                                                          .reminder ==
                                                                      'Peringatan'
                                                                  ? Text(
                                                                      '${locale.reminder!} ${medicine1.name ?? name1}',
                                                                      style: const TextStyle(
                                                                          color:
                                                                              black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )
                                                                  : Text(
                                                                      '${medicine1.name ?? name1} ${locale.reminder!}',
                                                                      style: const TextStyle(
                                                                          color:
                                                                              black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                              subtitle: Text(
                                                                '${medicine1.intake} ${locale.intake!}',
                                                                style:
                                                                    const TextStyle(
                                                                        color:
                                                                            black),
                                                              ),
                                                              trailing: Switch(
                                                                value: medicine1
                                                                    .medSwitch,
                                                                onChanged:
                                                                    (value) async {
                                                                  SharedPreferences
                                                                      prefs =
                                                                      await SharedPreferences
                                                                          .getInstance();
                                                                  medicine1
                                                                      .changeSwitch();
                                                                  firstMed1 =
                                                                      prefs.getBool(
                                                                              'firstMed1') ??
                                                                          true;
                                                                  setState(() {
                                                                    med1 = value;
                                                                  });
                                                                  if (med1 ==
                                                                      true) {
                                                                    if (firstMed1 ==
                                                                        true) {
                                                                      if (medicine1
                                                                              .intake ==
                                                                          0) {
                                                                        await prefs.setBool(
                                                                            'm1${AppUser.instance.user!.uid}',
                                                                            false);
                                                                        setState(
                                                                            () {
                                                                          Timer(
                                                                              const Duration(seconds: 2),
                                                                              back1);
                                                                        });
                                                                        Fluttertoast.showToast(
                                                                            msg: locale.water1 == 'air'
                                                                                ? 'Sila tetapkan bilangan ubat yang perlu diambil dalam sehari dahulu'
                                                                                : 'Please set number of medicine(s) intake in a day first');
                                                                      } else {
                                                                        CoolAlert.show(
                                                                            title: "${locale.takeYour} ${box.read('medicine1') ?? locale.medicineNo1!}",
                                                                            onCancelBtnTap: () async {
                                                                              Navigator.pop(context);
                                                                              await SharedPreferences.getInstance();
                                                                              await prefs.setBool('m1${AppUser.instance.user!.uid}',
                                                                                  false);
                                                                              setState(() {
                                                                                med1 = false;
                                                                              });
                                                                            },
                                                                            onConfirmBtnTap: () {
                                                                              Navigator.pop(context);
                                                                              medicine1.selectTimes(context,
                                                                                  DateTime.now(),
                                                                                  intake: 0);
                                                                            },
                                                                            context: context,
                                                                            type: CoolAlertType.info,
                                                                            text: hadis ? locale.strongHadisM : locale.strongQuranM,
                                                                            showCancelBtn: true,
                                                                            cancelBtnText: locale.back!,
                                                                            confirmBtnText: locale.selectTime!);
                                                                        hadis =
                                                                            !hadis;
                                                                      }
                                                                    } else {
                                                                      medicine1
                                                                          .getTime();
                                                                    }
                                                                  } else {
                                                                    medicine1
                                                                        .cancelNotifications();
                                                                    Fluttertoast.showToast(
                                                                        msg: locale
                                                                            .cancelReminder1!);
                                                                  }
                                                                },
                                                                activeColor:
                                                                    Colors.blue[
                                                                        400],
                                                                inactiveThumbColor:
                                                                    Colors.white,
                                                              ),
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          70.0),
                                                                  child: Text(
                                                                    locale
                                                                        .takeMedicine!,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                                for (int i = 0;
                                                                    i <
                                                                        medicine1
                                                                            .intake;
                                                                    i++)
                                                                  ListTile(
                                                                    leading: Icon(
                                                                      Icons
                                                                          .medical_services,
                                                                      semanticLabel:
                                                                          i.toString(),
                                                                    ),
                                                                    title: Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                                8.0),
                                                                        child: Text(
                                                                            medicine1
                                                                                .scheduleList![i])),
                                                                    trailing:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        CoolAlert.show(
                                                                            onCancelBtnTap: () => Navigator.pop(context),
                                                                            title: "${locale.takeYour} ${medicine1.name ?? locale.medicineNo1!}",
                                                                            onConfirmBtnTap: () {
                                                                              Navigator.pop(context);
                                                                              medicine1.selectTimes(context,
                                                                                  DateTime.now(),
                                                                                  intake: i);
                                                                            },
                                                                            context: context,
                                                                            type: CoolAlertType.info,
                                                                            text: hadis ? locale.strongHadisM : locale.strongQuranM,
                                                                            showCancelBtn: true,
                                                                            cancelBtnText: locale.back!,
                                                                            confirmBtnText: locale.selectTime!);
                                                                        hadis =
                                                                            !hadis;
                                                                      },
                                                                      child: Text(
                                                                          locale
                                                                              .editTime!),
                                                                    ),
                                                                  ),
                                                                ListTile(
                                                                  title:
                                                                      TextButton(
                                                                          onPressed:
                                                                              () async {
                                                                            showDialog(
                                                                                builder: (BuildContext context) {
                                                                                  return Consumer<Medicine1Provider>(builder: (context, medic1, child) {
                                                                                    return AlertDialog(
                                                                                      title: Text(locale.editMedicineTitle!),
                                                                                      content: SizedBox(
                                                                                        height: MediaQuery.of(context).size.height * 0.25,
                                                                                        child: SingleChildScrollView(
                                                                                          child: Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                            children: [
                                                                                              if (medicine1.name != null)
                                                                                                Column(
                                                                                                  children: [
                                                                                                    Align(
                                                                                                        alignment: Alignment.topLeft,
                                                                                                        child: Text(
                                                                                                          locale.editMedicineName!,
                                                                                                          style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                                                                                                        )),
                                                                                                    Align(
                                                                                                        alignment: Alignment.topLeft,
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              medicine1.name!,
                                                                                                            ),
                                                                                                            const Spacer(),
                                                                                                            IconButton(onPressed: () => Provider.of<Medicine1Provider>(context, listen: false).changeVisible(), icon: const Icon(Icons.edit))
                                                                                                          ],
                                                                                                        )),
                                                                                                  ],
                                                                                                ),
                                                                                              Visibility(
                                                                                                visible: medicine1.name != null ? medicine1.visible : true,
                                                                                                child: FormField<String>(
                                                                                                  builder: (FormFieldState<String> state) {
                                                                                                    return InputDecorator(
                                                                                                      decoration: InputDecoration(border: InputBorder.none, errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0), label: Text(locale.editMedicineName!)),
                                                                                                      child: TextFormField(
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        textCapitalization: TextCapitalization.sentences,
                                                                                                        controller: _detailM,
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                              FormField<String>(
                                                                                                builder: (FormFieldState<String> state) {
                                                                                                  return InputDecorator(
                                                                                                    decoration: InputDecoration(errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 16.0), hintText: '', label: Text(locale.selectIntake!)),
                                                                                                    isEmpty: _currentSelectedValue == '',
                                                                                                    child: DropdownButtonHideUnderline(
                                                                                                      child: DropdownButton<String>(
                                                                                                        value: _currentSelectedValue,
                                                                                                        isDense: true,
                                                                                                        onChanged: (String? newValue) {
                                                                                                          setState(() {
                                                                                                            _currentSelectedValue = newValue;
                                                                                                            box.write('medicine1Intake', _currentSelectedValue);
                                                                                                            state.didChange(newValue);
                                                                                                          });
                                                                                                        },
                                                                                                        items: _no.map((String value) {
                                                                                                          return DropdownMenuItem<String>(
                                                                                                            value: value,
                                                                                                            child: Text(value),
                                                                                                          );
                                                                                                        }).toList(),
                                                                                                      ),
                                                                                                    ),
                                                                                                  );
                                                                                                },
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                            onPressed: () async {
                                                                                              if (medicine1.visible == true && _detailM.text != '') {
                                                                                                setState(() {
                                                                                                  box.write('medicine1', _detailM.text);
                                                                                                });
                                                                                              }
                                                                                              if (_detailM.text != '') {
                                                                                                setState(() {
                                                                                                  box.write('medicine1', _detailM.text);
                                                                                                });
                                                                                              }
                                                                                              if (_currentSelectedValue != null) {
                                                                                                setState(() {
                                                                                                  box.write('medicine1Intake', _currentSelectedValue);
                                                                                                });
                                                                                              }
                                                                                              if (medicine1.visible == true && _detailM.text == '' || _currentSelectedValue == null) {
                                                                                                showTopSnackBar(
                                                                                                  context,
                                                                                                  CustomSnackBar.error(
                                                                                                    icon: const Icon(
                                                                                                      Icons.error,
                                                                                                      size: 88,
                                                                                                    ),
                                                                                                    message: locale.pleaseFillAllFields!,
                                                                                                  ),
                                                                                                );
                                                                                              } else {
                                                                                                _detailM.clear();
                                                                                                _currentSelectedValue = null;
                                                                                                Provider.of<Medicine1Provider>(context, listen: false).getMedicine();
                                                                                                if (medicine1.visible = true) {
                                                                                                  Provider.of<Medicine1Provider>(context, listen: false).changeVisible();
                                                                                                }
                                                                                                Navigator.pop(context);
                                                                                                showTopSnackBar(
                                                                                                  context,
                                                                                                  CustomSnackBar.success(
                                                                                                    message: locale.medicineUpdated!,
                                                                                                  ),
                                                                                                );
                                                                                              }
                                                                                            },
                                                                                            child: Text(locale.update!))
                                                                                      ],
                                                                                    );
                                                                                  });
                                                                                },
                                                                                context: context);
                                                                          },
                                                                          child: Text(
                                                                              locale.editMedicineTitle!)),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                            ),
                                            DefaultCircleCard(
                                              icon: const Icon(
                                                Icons.grid_view,
                                                size: 40,
                                              ),
                                              label: 'Others',
                                              onPress: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DefaultDialog(
                                                    body: StatefulBuilder(builder:
                                                        (context, setState) {
                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          dialogBody(
                                                              'Coming Soon'),
                                                          dialogButton(
                                                            'Close',
                                                            ' ',
                                                            () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          )))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Align dialogTime(time) {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        time,
        style: textStyleBoldSmall,
      ),
    );
  }

  Container dialogBody(bodyText) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 25),
      child: Text(
        bodyText,
        style: textStyleNormal,
        textAlign: TextAlign.center,
      ),
    );
  }

  Column dialogHeader(headerText) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            headerText,
            style: textStyleBold,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: 50,
            child: Transform.scale(
              transformHitTests: false,
              scale: .5,
              child: CupertinoSwitch(
                value: _switch,
                onChanged: (value) {
                  setState(() {
                    _switch = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }

  Row dialogButton(
    onSubmitText,
    onCancelText,
    VoidCallback? onSubmit,
    VoidCallback? onCancel,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: DefaultButton(
            onPress: onCancel,
            label: onCancelText,
            textStyle: textStyleNormalGrey,
          ),
        ),
        Expanded(
          child: DefaultButton(
            onPress: onSubmit,
            label: onSubmitText,
            textStyle: textStyleNormal,
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }

  Future<dynamic> dialogPopup(
    BuildContext context,
    headerText,
    bodyText,
    onSubmitText,
    onCancelText,
    VoidCallback? onSubmit,
    VoidCallback? onCancel,
    time,
  ) {
    return showDialog(
      context: context,
      builder: (context) => DefaultDialog(
        body: StatefulBuilder(builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      headerText,
                      style: textStyleBold,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 50,
                      child: Transform.scale(
                        transformHitTests: false,
                        scale: .5,
                        child: CupertinoSwitch(
                          value: _switch,
                          onChanged: (value) {
                            setState(() {
                              _switch = value;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              Column(
                children: [
                  if (time != '')
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            time,
                            style: textStyleBoldSmall,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  Text(
                    bodyText,
                    style: textStyleNormal,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DefaultButton(
                          onPress: onCancel,
                          label: onCancelText,
                          textStyle: textStyleNormalGrey,
                        ),
                      ),
                      Expanded(
                        child: DefaultButton(
                          onPress: onSubmit,
                          label: onSubmitText,
                          textStyle: textStyleNormal,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ],
                  ),
                ],
              )

              // ShowModalBody(
              //   bodyText: kDefaultText,
              //   time: 'Time: 9:00 AM',
              //   onCancelText: 'Back',
              //   onCancel: () {
              //     Navigator.pop(context);
              //   },
              //   onSubmit: () {
              //     Navigator.pop(context);
              //   },
              //   onSubmitText: 'Select Time',
              // )
            ],
          );
        }),
      ),
    );
  }

  Future getAllHadis() => _stopLoad.runOnce(() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          _bookmark = prefs.getStringList('bookMarks') ?? [];
        });
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('habbatus_madu')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('habbatus_madu')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('penyakit')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('penyakit')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('tahajjud')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('tahajjud')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('air')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                setState(() {
                  _list.add(
                      '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                });
              } else {
                setState(() {
                  _list.add(
                      '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                });
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('tahajjud')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('sedekah')
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              if (doc["terjemahanQuran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            }
          });
        } else {
          await FirebaseFirestore.instance
              .collection('sedekah')
              .get()
              .then((QuerySnapshot querySnapshot) {
            for (var doc in querySnapshot.docs) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            }
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('doa_zikir')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('doa_zikir')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('istiqamah')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('istiqamah')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        }
        if (AppLocalizations.of(context)!.water1 == 'air') {
          await FirebaseFirestore.instance
              .collection('makanan_halal')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["terjemahanQuran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanHadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["terjemahanQuran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection('makanan_halal')
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              if (doc["translation_quran"] == '') {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_hadith"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["kitabDanNomborHadith"]})');
                  });
                }
              } else {
                if (mounted) {
                  setState(() {
                    _list.add(
                        '${doc["translation_quran"].trim().replaceAll('�', '').replaceAll('(?)', '').replaceAll('?\n', '').replaceAll('Rasulullah ?', 'Rasulullah')} (${doc["surahDanAyat"]})');
                  });
                }
              }
            });
          });
        }
        print(_list.length);
      });
}

class ShowModalBody extends StatelessWidget {
  ShowModalBody(
      {this.bodyText,
      this.time,
      this.onCancel,
      this.onSubmit,
      required this.onCancelText,
      required this.onSubmitText});

  String? time;
  String? bodyText;

  VoidCallback? onSubmit;
  VoidCallback? onCancel;

  final String onCancelText;
  final String onSubmitText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Text(
            "$time",
            style: textStyleBoldSmall,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          kDefaultText,
          style: textStyleNormal,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DefaultButton(
                onPress: () {
                  Navigator.pop(context);
                },
                label: onCancelText,
                textStyle: textStyleNormalGrey,
              ),
            ),
            Expanded(
              child: DefaultButton(
                onPress: () {
                  Navigator.pop(context);
                },
                label: onSubmitText,
                textStyle: textStyleNormal,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MyDialog extends StatefulWidget {
  final int waterintake;

  const MyDialog(this.waterintake, {Key? key}) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  String e = '';
  bool isSwitched2 = false;
  final box = GetStorage();

  int numbW = 0;

  bool hadis = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Consumer<WaterProvider>(builder: (context, water, child) {
      return AlertDialog(
        title: Text(
          '${widget.waterintake}${Emojis.wheater_droplet}${locale.reminder!}',
          textAlign: TextAlign.center,
        ),
        content: waterDialog(context),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              water.cancelNotifications();
              Fluttertoast.showToast(msg: locale.cancelWaterReminder!);
              Navigator.pop(context, false);
            },
            child: Text(locale.back!),
            style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
          ),
          ElevatedButton(
            onPressed: () async {
              if (water.scheduleList![0] != '(N/A)') {
                water.getTime();

                Navigator.pop(context, true);
              } else {
                showTopSnackBar(
                  context,
                  CustomSnackBar.error(
                    message: locale.waterIntakeError!,
                  ),
                );
              }
            },
            child: Text(locale.done1!),
            style: TextButton.styleFrom(backgroundColor: kPrimaryColor),
          ),
        ],
      );
    });
  }

  Widget waterDialog(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Consumer<WaterProvider>(builder: (context, water, child) {
        return Column(
          children: [
            SizedBox(
              height: widget.waterintake < 6 ? widget.waterintake * 60 : 350,
              // Change as per your requirement
              width: 300.0,
              // Change as per your requirement
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: water.scheduleList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(
                      water.scheduleList![index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: water.scheduleList![index] != '(N/A)'
                        ? TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.amber),
                            onPressed: () async {
                              CoolAlert.show(
                                  title: locale.waterReminder,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                    water.cancelNotifications();
                                    water.selectTimes(context, DateTime.now(),
                                        'waterIntake$index', index);
                                  },
                                  context: context,
                                  type: CoolAlertType.info,
                                  text: hadis
                                      ? 'Allahumma inni as aluka ilman naafian wa rizqan waasian wa syifaan min kulli daa in \n\n${locale.doaW}'
                                      : locale.strongHadisW,
                                  showCancelBtn: true,
                                  cancelBtnText: locale.back!,
                                  confirmBtnText: locale.selectTime!);
                              hadis = !hadis;
                            },
                            child: Text(
                              locale.view!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: kPrimaryColor),
                            onPressed: () async {
                              CoolAlert.show(
                                  title: hadis ? 'Do\'a' : locale.waterReminder,
                                  onConfirmBtnTap: () {
                                    Navigator.pop(context);
                                    water.cancelNotifications();
                                    water.selectTimes(context, DateTime.now(),
                                        'waterIntake$index', index);
                                  },
                                  context: context,
                                  type: CoolAlertType.info,
                                  text: hadis
                                      ? 'Allahumma inni as aluka ilman naafian wa rizqan waasian wa syifaan min kulli daa in \n\n${locale.doaW}'
                                      : locale.strongHadisW,
                                  showCancelBtn: true,
                                  cancelBtnText: locale.back!,
                                  confirmBtnText: locale.selectTime!);
                              hadis = !hadis;
                            },
                            child: Text(
                              locale.add!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  void close(String a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (a == 'isSwitched2') {
      await prefs.setBool('W${AppUser.instance.user!.uid}', false);
    }
  }
}
