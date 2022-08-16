import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:istiqamah_app/models/user.model.dart';
import 'package:istiqamah_app/screen/next_update_profile.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Locale/locales.dart';
import '../constants/constant.dart';

// ignore: must_be_immutable
class VerifyPhoneNumberScreen extends StatefulWidget {
  final String phoneNumber;

  VerifyPhoneNumberScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  String? _enteredOTP;

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  TextButton(
                    onPressed: controller.isOtpExpired
                        ? null
                        : () async => await controller.sendOTP(),
                    child: Text(
                      controller.isOtpExpired
                          ? "${controller.otpExpirationTimeLeft.inSeconds}s"
                          : "RESEND",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                const SizedBox(width: 5),
              ],
            ),
            body: controller.codeSent
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      const SizedBox(height: 25),
                      Text(
                        "${locale.verifyDescription!} ${widget.phoneNumber}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      //const Divider(),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height:
                            controller.isListeningForOtpAutoRetrieve ? null : 0,
                        child: Column(
                          children: const [
                            CircularProgressIndicator.adaptive(),
                            SizedBox(height: 50),
                            // Text(
                            //   "Listening for OTP",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     fontSize: 25,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                            // Divider(),
                            // Text("OR", textAlign: TextAlign.center),
                            //Divider(),
                          ],
                        ),
                      ),
                      Text(
                        locale.enterOTP!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextField(
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        onChanged: (String v) async {
                          _enteredOTP = v;
                          if (_enteredOTP?.length == 6) {
                            final isValidOTP = await controller.verifyOtp(
                              _enteredOTP!,
                            );
                            // Incorrect OTP
                            if (!isValidOTP) {
                              _showSnackBar(
                                context,
                                "${locale.enterCorrectOTP!} ${widget.phoneNumber}",
                              );
                            }
                          }
                        },
                      ),
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
}
