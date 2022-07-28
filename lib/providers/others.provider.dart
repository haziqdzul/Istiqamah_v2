import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_app/providers/user.provider.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Locale/locales.dart';

class Medicine2Provider extends ChangeNotifier {
  List<String>? scheduleList = [];
  List ubat = [];
  List medicine = [];
  bool load = false;
  String langCode = 'My';
  String? name;
  int intake = 0;
  final box = GetStorage();
  bool medSwitch = false;
  bool visible = false;

  Future<void> getSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList('medicine2') ?? [];
    if (list.isNotEmpty) {
      scheduleList = list;
      notifyListeners();
    }
    print(scheduleList);
  }

  Future<void> getMedicine() async {
    final prefs = await SharedPreferences.getInstance();
    name = box.read('medicine2');
    intake = int.parse(box.read('medicine2Intake') ?? "0");
    medSwitch = prefs.getBool('m2${AppUser.instance.user!.uid}') ?? false;
    getMedicineIntake(intake);
    notifyListeners();
  }

  void getMedicineIntake(int intake) {
    if (intake != 0) {
      for (int i = 0; i < intake; i++) {
        scheduleList!.add("(N/A)");
      }
    }
  }

  Future<void> changeSwitch() async {
    final prefs = await SharedPreferences.getInstance();
    medSwitch = !medSwitch;
    prefs.setBool('m2${AppUser.instance.user!.uid}', medSwitch);
    notifyListeners();
  }

  void changeVisible() {
    visible = !visible;
    notifyListeners();
  }

  Future<void> selectTimes(BuildContext context, DateTime date,
      {int? intake}) async {
    List<String>? list = [];
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
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
            onSubmit: (index) {
              schedule = index;
              if (schedule != date) {
                final now = DateTime.now();
                final dif = schedule.difference(now);
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
                prefs.setBool('m2${AppUser.instance.user!.uid}', true);
                var num = int.parse(box.read('medicine2Intake'));
                var hr = 0;
                var interval = 0;
                if (num == 2) {
                  interval = 12;
                }
                if (num == 3) {
                  interval = 8;
                }
                if (num == 4) {
                  interval = 6;
                }
                for (int number = 0; number < num; number++) {
                  var time = DateTime(schedule.year, schedule.month,
                      schedule.day, schedule.hour + hr, schedule.minute, 0, 0);
                  list.add(DateFormat.jm().format(time));
                  createMedicineReminderNotification(time, number);
                  hr = hr + interval;
                }
                prefs.setStringList('medicine2', list);
                getSchedule();
                notifyListeners();
              }
            },
            onClose: () {
              medSwitch = false;
              notifyListeners();
            },
            // bottomPickerTheme: BOTTOM_PICKER_THEME.orange,
            use24hFormat: false)
        .show(context);
    medSwitch = true;
    notifyListeners();
  }

  Future<void> createMedicineReminderNotification(
      DateTime d, int intake) async {
    print('set medicine2 ${intake + 1} notification');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstMed2', false);
    Random random = Random();
    if (ubat.isNotEmpty || medicine.isNotEmpty) {
      for (int index = 0; index < 30; index++) {
        var time = DateTime(
            d.year, d.month, d.day + index, d.hour, d.minute, d.second, 0, 0);
        var num =
            random.nextInt(langCode == 'My' ? ubat.length : medicine.length);
        var str = langCode == 'My'
            ? ubat[num]
                .trim()
                .replaceAll('�', '')
                .replaceAll('(?)', '')
                .replaceAll('?\n', '')
                .replaceAll('Rasulullah ?', 'Rasulullah')
            : medicine[num]
                .trim()
                .replaceAll('�', '')
                .replaceAll('(?)', '')
                .replaceAll('?\n', '')
                .replaceAll('Rasulullah ?', 'Rasulullah');
        await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1000 + intake + index,
              channelKey: 'medicine2_channel',
              title: langCode == 'My'
                  ? '${Emojis.medical_pill} Jangan lupa ambil ${name ?? 'ubat'} anda'
                  : '${Emojis.medical_pill} Reminder to take your ${name ?? 'medicine'}',
              body: langCode == 'My'
                  ? ubat.isNotEmpty
                      ? str
                      : 'Data not loaded'
                  : medicine.isNotEmpty
                      ? str
                      : 'Data not loaded',
              summary: langCode == 'My'
                  ? 'Notifikasi ${name ?? 'Ubat'}'
                  : '${name ?? 'Medicine'} Notification',
              wakeUpScreen: true,
              category: NotificationCategory.Reminder,
              autoDismissible: false,
              notificationLayout: NotificationLayout.BigText,
            ),
            actionButtons: [
              NotificationActionButton(
                  key: "ARCHIVE",
                  label: langCode == 'My' ? 'Langkau' : 'Skip',
                  autoDismissible: true,
                  color: Colors.yellow,
                  buttonType: ActionButtonType.Default),
              NotificationActionButton(
                  key: "TAKE",
                  label: langCode == 'My' ? 'Tandakan dibaca' : 'Mark as read',
                  color: Colors.yellow,
                  buttonType: ActionButtonType.Default),
              NotificationActionButton(
                  key: 'SNOOZE',
                  label: langCode == 'My'
                      ? 'Tunda selama 5 minit'
                      : 'Snooze for 5 minutes',
                  color: Colors.yellow,
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
  }

  Future<void> getTime() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList("medicine1") ?? [];
    List<DateTime> newTime = [];
    if (list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        String time = list[i];
        DateTime now = DateTime.now();
        String formatTime = "0${now.year}.${now.month}.${now.day} AD $time";
        newTime.add(DateFormat('yyyyy.MM.dd GGG hh:mm aaa').parse(formatTime));

        if (newTime[i != 0 ? i - 1 : i].hour >= 22 ||
            newTime[i != 0 ? i - 1 : i].day > newTime[i].day) {
          var date = DateTime(
              newTime[i].year,
              newTime[i].month,
              newTime[i].hour >= 22 ? newTime[i].day : newTime[i].day + 1,
              newTime[i].hour,
              newTime[i].minute,
              0);

          createMedicineReminderNotification(date, i);
        } else {
          createMedicineReminderNotification(newTime[i], i);
        }
      }
    }
    notifyListeners();
  }

  Future<void> getHadisAndQuranVerse(String code) async {
    print('load medicine2 hadith and quran verse');
    langCode = code;
    await FirebaseFirestore.instance
        .collection('penyakit')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (code == 'My') {
          if (doc['terjemahanHadith'] != '' &&
              doc['terjemahanHadith'].length < 400) {
            ubat.add(
                '${doc['terjemahanHadith']} (${doc['kitabDanNomborHadith']}) ');
          } else {
            if (doc['terjemahanQuran'] != '' &&
                doc['terjemahanQuran'].length < 400) {
              ubat.add('${doc['terjemahanQuran']} (${doc['surahDanAyat']}) ');
            }
          }
        } else if (code == 'En') {
          if (doc['translation_hadith'] != '' &&
              doc['translation_hadith'].length < 400) {
            medicine.add(
                '${doc['translation_hadith']} (${doc['kitabDanNomborHadith']}) ');
          } else {
            if (doc['translation_quran'] != '' &&
                doc['translation_quran'].length < 400) {
              medicine
                  .add('${doc['translation_quran']} (${doc['surahDanAyat']}) ');
            }
          }
        }
      }
    });
    load = true;
    notifyListeners();
  }

  Future<void> cancelNotifications() async {
    for (var i = 1000; i < 1000 + 30 + intake; i++) {
      await AwesomeNotifications().cancel(i);
      print('cancel notification id: $i');
    }
  }
}
