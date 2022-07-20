import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Locale/locales.dart';
import '../constants/constant.dart';
import 'NavigationDrawer.dart';

class MLSplashScreenHadis extends StatefulWidget {
  const MLSplashScreenHadis({Key? key}) : super(key: key);

  @override
  _MLSplashScreenState createState() => _MLSplashScreenState();
}

class _MLSplashScreenState extends State<MLSplashScreenHadis> {
  @override
  void initState() {
    super.initState();
    //
    init();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kSecondaryColor, kPrimaryColor])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/quranlogo.png',
              height: 150,
              width: 150,
              fit: BoxFit.fill,
            ).center(),
            DelayedDisplay(
              delay: const Duration(seconds: 2),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.2)
                        ],
                        stops: const [
                          0.0,
                          1.0
                        ])),
                child: Column(
                  children: [
                    Text(locale.companyHadith!,
                            textAlign: TextAlign.center,
                            style: boldTextStyle(color: Colors.white, size: 20))
                        .center(),
                    Text(locale.companyHadithNarrated!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16))
                        .center(),
                    10.height,
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.black,
                          fixedSize: const Size(360, 30),
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationDrawer(
                                        txt: 0,
                                      )));
                        },
                        child: Text(locale.proceed!))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
