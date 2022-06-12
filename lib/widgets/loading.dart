import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Locale/locales.dart';
import '../screen/update_profile.screen.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: SpinKitChasingDots(
          color: Colors.yellow,
          size: 80.0,
        ),
      ),
    );
  }
}

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    if (mounted) {
      super.initState();
      user = auth.currentUser!;
      user.sendEmailVerification();
      timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        //check if email is verified
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitChasingDots(
                color: Colors.yellow,
                size: 50.0,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(locale.loadingScreen!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              // TimerButton(
              //   label: locale.loadingBack!,
              //   timeOutInSeconds: 20,
              //   onPressed: () async {
              //     await AppUser.instance.signOut();
              //     Navigator.pop(context);
              //   },
              //   disabledColor: Colors.grey,
              //   color: Colors.cyan,
              //   buttonType: ButtonType.ElevatedButton,
              //   disabledTextStyle:
              //       const TextStyle(fontSize: 16.0, color: Colors.grey),
              //   activeTextStyle:
              //       const TextStyle(fontSize: 16.0, color: Colors.cyan),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      //navigate to home page
      timer.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MLUpdateProfileScreen()));
    }
  }
}
