import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class LanguageProvider extends ChangeNotifier {
  GetStorage box = GetStorage();
  String? local;
  factory LanguageProvider() => LanguageProvider._();
  LanguageProvider._() {
    getLocale();
  }

  void changeLocale(code) {
    local = code;
    print(local);
    notifyListeners();
  }

  void getLocale() {
    local = box.read('lang') ?? 'My';
    
  }
}
