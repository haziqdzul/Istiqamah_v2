import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class LanguageCubit extends Cubit<Locale> {
  static var box = GetStorage();

  LanguageCubit()
      : super(box.read('lang') == 'En' && box.read('lang') != null
            ? const Locale('en')
            : const Locale('id'));

  void selectEngLanguage() {
    emit(const Locale('en'));
  }

  void selectArabicLanguage() {
    emit(const Locale('ar'));
  }

  void selectPortugueseLanguage() {
    emit(const Locale('pt'));
  }

  void selectFrenchLanguage() {
    emit(const Locale('fr'));
  }

  void selectIndonesianLanguage() {
    emit(const Locale('id'));
  }

  void selectSpanishLanguage() {
    emit(const Locale('es'));
  }

  void selectItalianLanguage() {
    emit(const Locale('it'));
  }

  void selectTurkishLanguage() {
    emit(const Locale('tr'));
  }

  void selectSwahiliLanguage() {
    emit(const Locale('sw'));
  }

// void selectMalaysianLanguage() {
//   emit(Locale('ms'));
// }
}
