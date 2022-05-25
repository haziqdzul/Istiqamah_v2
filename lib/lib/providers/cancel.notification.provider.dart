import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class CancelNotificationProvider extends ChangeNotifier {
  Future<void> cancel(type) async {
    if (type == 'sadaqah') {
      for (var i = 30; i < 60; i++) {
        await AwesomeNotifications().cancel(i);
      }
    } else if (type == 'tahajjud') {
      for (var i = 60; i < 90; i++) {
        await AwesomeNotifications().cancel(i);
      }
    }
  }
}
