import 'dart:async';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../Locale/locales.dart';
import '../../models/user.model.dart';
import '../constants/constant.dart';
import 'next_update_profile.dart';

// ignore: must_be_immutable
class VerifyPhoneNumberScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyPhoneNumberScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  @override
  void initState() {
    sendOtp();
    Timer(const Duration(seconds: 60), updateTimer);
    super.initState();
  }

  String? _enteredOTP;

  String text = '';
  bool timeout = false;
  String? verificationId;

  get smsCode => null;

  void updateTimer() {
    setState(() {});
    timeout = !timeout;
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: widget.phoneNumber,
        autoRetrievalTimeOutDuration: const Duration(seconds: 60),
        onLoginSuccess: (userCredential, autoVerified) async {
          _showSnackBar(
            context,
            'Phone number verified successfully!',
          );

          debugPrint(
            autoVerified
                ? "OTP was fetched automatically"
                : "OTP was verified manually",
          );

          debugPrint("Login Success UID: ${userCredential.user?.uid}");
        },
        onLoginFailed: (authException, stackTrace) {
          _showSnackBar(
            context,
            'Something went wrong (${authException.message})',
          );

          debugPrint(authException.message);
          // handle error further if needed
        },
        builder: (context, controller) {
          var locale = AppLocalizations.of(context)!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kSecondaryColor,
              title: Text(locale.verifyPhoneNumber!),
              actions: [
                if (controller.codeSent)
                  //if (timeout)
                  TextButton(
                      child: Text(
                        locale.resentOTP!,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        await sendOtp();
                        setState(() {
                          timeout = false;
                        });
                      }),
                const SizedBox(width: 5),
              ],
            ),
            body: verificationId != null
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Text(
                        "${locale.verifyDescription!} ${widget.phoneNumber}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      Text(
                        locale.enterOTP!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            otpNumberWidget(0),
                            otpNumberWidget(1),
                            otpNumberWidget(2),
                            otpNumberWidget(3),
                            otpNumberWidget(4),
                            otpNumberWidget(5),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      NumericKeyboard(
                        onKeyboardTap: _onKeyboardTap,
                        textColor: Colors.black,
                        rightIcon: const Icon(
                          Icons.backspace,
                          color: Colors.blueAccent,
                        ),
                        rightButtonFn: () {
                          setState(() {
                            text = text.substring(0, text.length - 1);
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () async {
                            if (_enteredOTP?.length == 6) {
                              try {
                                PhoneAuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId!,
                                        smsCode: _enteredOTP!);
                                await FirebaseAuth.instance.currentUser!
                                    .updatePhoneNumber(credential);
                                _showSnackBar(
                                  context,
                                  locale.successVerified!,
                                );
                                await NextUpdateProfileScreen(
                                  userData.gender ?? '',
                                  userData.title ?? '',
                                  userData.dob ?? '',
                                  userData.country ?? '',
                                  userData.state ?? '',
                                  userData.city ?? '',
                                  userData.postcode ?? '',
                                  userData.address1 ?? '',
                                  userData.address2 ?? '',
                                  userData.address3 ?? '',
                                  '${userData.cc}${userData.phoneNo}',
                                ).launch(context);
                              } catch (e) {
                                // Incorrect OTP
                                _showSnackBar(
                                  context,
                                  "${locale.enterCorrectOTP!} ${widget.phoneNumber}",
                                );
                              }
                            } else {
                              _showSnackBar(
                                context,
                                locale.water1 == 'air'
                                    ? 'Otp must equal to 6'
                                    : 'Otp hendaklah 6 digit',
                              );
                            }
                          },
                          child: Text(locale.submit!))
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator.adaptive(),
                      const SizedBox(height: 50),
                      Center(
                        child: Text(
                          locale.sendingOTP!,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: const TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  Future<void> _onKeyboardTap(String value) async {
    setState(() {
      text = text + value;
      _enteredOTP = text;
    });
  }

  Future<void> sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 60),
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) async {
        if (e.code == 'invalid-phone-number') {
          _showSnackBar(context, 'The provided phone number is not valid.');
        }
      },
      codeSent: (String verId, int? resendToken) async {
        // Create a PhoneAuthCredential with the code
        setState(() {
          verificationId = verId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
