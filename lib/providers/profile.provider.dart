import 'package:flutter/material.dart';
import 'package:istiqamah_app/providers/user.provider.dart';

class ProfileProvider extends ChangeNotifier {
  String? url;

  Future<void> getProfile() async {
    url = AppUser.instance.user!.photoURL ??
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png';
    notifyListeners();
  }
}
