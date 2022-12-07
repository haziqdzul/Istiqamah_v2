import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:istiqamah_app/providers/user.provider.dart';
import 'package:istiqamah_app/screen/NavigationDrawer.dart';
import 'package:istiqamah_app/screen/home_page.dart';
import 'package:istiqamah_app/screen/login_page.dart';
import 'package:istiqamah_app/screen/splash.screen.hadis.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppUser>(builder: (context, app, _) {
        if (app.user == null) {
          return const MLLoginScreen();
        } else {
          return MLSplashScreenHadis();
        }
      }),
    );
  }
}
