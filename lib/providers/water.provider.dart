import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Locale/locales.dart';

class WaterProvider extends ChangeNotifier {
  List<String>? scheduleList = [];
  int waterIntake = 0;
  List water = [];
  List air = [];
  bool load = false;
  String langCode = 'My';

  Future<void> getSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList('waters') ?? [];
    if (list.isNotEmpty) {
      scheduleList = list;
      notifyListeners();
    }
  }

  Future<void> getWaterIntake(int intake) async {
    if (scheduleList!.isEmpty || scheduleList!.length < intake) {
      for (int i = 0 + scheduleList!.length < intake ? scheduleList!.length : 0;
          i < intake;
          i++) {
        scheduleList!.add("(N/A)");
      }
      waterIntake = intake;
      notifyListeners();
    }
  }

  void selectTimes(
      BuildContext context, DateTime date, String document, int wid) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList('waters') ?? [];
    DateTime schedule;
    var locale = AppLocalizations.of(context)!;
    var newTime =
        DateTime(date.year, date.month, date.day, date.hour, date.minute + 2);
    BottomPicker.time(
            pickerTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
            initialDateTime: newTime,
            minDateTime: newTime,
            title: locale.setNotificationTime!,
            titleStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
            onSubmit: (index) {
              schedule = index;

              if (schedule != date) {
                if (wid != 0) list.removeRange(wid, list.length);
                if (wid == 0) list.clear();
                var hr = 0;
                for (int i = wid; i < waterIntake; i++) {
                  list.add(DateFormat.jm().format(DateTime(
                      schedule.year,
                      schedule.month,
                      schedule.day,
                      schedule.hour + hr,
                      schedule.minute,
                      0,
                      0)));
                  hr = hr + 2;
                }

                prefs.setStringList('waters', list);
                List<String>? newList = prefs.getStringList('waters') ?? [];
                scheduleList = newList;
                notifyListeners();
              }
            },
            // bottomPickerTheme: BOTTOM_PICKER_THEME.blue,
            use24hFormat: false)
        .show(context);
  }

  Future<void> cancelNotifications() async {
    for (var i = 90; i < 7 + waterIntake + 90; i++) {
      await AwesomeNotifications().cancel(i);
    }
  }

  Future<void> getTime() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList("waters") ?? [];
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

          createWaterReminderNotification(date, i);
        } else {
          createWaterReminderNotification(newTime[i], i);
        }
      }
    }
    notifyListeners();
  }

  Future<void> createWaterReminderNotification(DateTime d, int i) async {
    print('Set water ${i + 1}notification');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Random random = Random();
    await prefs.setBool('firstWater', false);
    if (air.isNotEmpty || water.isNotEmpty) {
      var num = random.nextInt(langCode == 'My' ? air.length : water.length);
      var str = langCode == 'My'
          ? air[num]
              .trim()
              .replaceAll('�', '')
              .replaceAll('(?)', '')
              .replaceAll('?\n', '')
              .replaceAll('Rasulullah ?', 'Rasulullah')
          : water[num]
              .trim()
              .replaceAll('�', '')
              .replaceAll('(?)', '')
              .replaceAll('?\n', '')
              .replaceAll('Rasulullah ?', 'Rasulullah');
      for (int index = 0; index < 30; index++) {
        var time = DateTime(
            d.year, d.month, d.day + index, d.hour, d.minute, d.second, 0, 0);
        await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: i + 90 + index,
              channelKey: 'water_channel',
              title:
                  '${Emojis.wheater_droplet} ${langCode == 'My' ? 'Jangan lupa ambil air anda, hari ini!' : 'Don\'t forget to take water, today'}',
              body: langCode == 'My'
                  ? air.isNotEmpty
                      ? str
                      : 'Data not loaded'
                  : water.isNotEmpty
                      ? str
                      : 'Data not loaded',
              summary: 'Water Notification',
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
                  buttonType: ActionButtonType.Default),
              NotificationActionButton(
                  key: "TAKE",
                  label: langCode == 'My' ? 'Tandakan dibaca' : 'Mark as read',
                  buttonType: ActionButtonType.Default),
              NotificationActionButton(
                  key: 'SNOOZE',
                  label: langCode == 'My'
                      ? 'Tunda selama 5 minit'
                      : 'Snooze for 5 minutes',
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
  }

  Future<void> getHadisAndQuranVerse(String code) async {
    print('load water hadith and quran verse');
    langCode = code;
    await FirebaseFirestore.instance
        .collection('air')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (code == 'My') {
          if (doc['terjemahanHadith'] != '' &&
              doc['terjemahanHadith'].length < 400) {
            air.add(
                '${doc['terjemahanHadith']} (${doc['kitabDanNomborHadith']}) ');
          } else {
            if (doc['terjemahanQuran'] != '' &&
                doc['terjemahanQuran'].length < 400) {
              air.add('${doc['terjemahanQuran']} (${doc['surahDanAyat']}) ');
            }
          }
        } else if (code == 'En') {
          if (doc['translation_hadith'] != '' &&
              doc['translation_hadith'].length < 400) {
            water.add(
                '${doc['translation_hadith']} (${doc['kitabDanNomborHadith']}) ');
          } else {
            if (doc['translation_quran'] != '' &&
                doc['translation_quran'].length < 400) {
              water
                  .add('${doc['translation_quran']} (${doc['surahDanAyat']}) ');
            }
          }
        }
      }
    });
    load = true;
    notifyListeners();
  }
}
