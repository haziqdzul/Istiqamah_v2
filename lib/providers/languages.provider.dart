import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  String local = 'My';

  void changeLocale(code) {
    local = code;
    notifyListeners();
  }
}
