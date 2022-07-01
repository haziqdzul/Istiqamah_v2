import 'package:flutter/material.dart';
import 'package:istiqamah_app/screen/home_page.dart';
import 'package:istiqamah_app/screen/login_page.dart';
import 'package:istiqamah_app/screen/notification_page.dart';
import 'package:istiqamah_app/screen/setting_page.dart';

class PageRoutes {
  static const String appNavigation = "appNavigation";
  static const String addAddress = "addAddress";
  static const String faqs = "faqs";
  static const String language = "language";
  static const String manageAddress = "manageAddress";
  static const String myProfile = "myProfile";
  static const String privacyPolicy = "privacyPolicy";
  static const String support = "support";
  static const String setting = "setting";
  static const String login = "login";
  static const String homepage = "home";
  static const String notification = "notification";
  static const String water = "water";
  static const String history = "history";
  Map<String, WidgetBuilder> routes() {
    return {
      setting: (context) => const SettingPage(),
      login: (context) => const MLLoginScreen(),
      homepage: (context) => HomePage(),
      notification: (context) => const NotificationPage(2),
    };
  }
}
