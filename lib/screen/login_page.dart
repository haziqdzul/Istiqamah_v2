import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istiqamah_app/screen/forgot_page.dart';
import 'package:istiqamah_app/screen/registerPage.dart';
import 'package:istiqamah_app/screen/splash.screen.hadis.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'dart:async';
import '../Locale/locales.dart';
import '../constants/constant.dart';
import '../providers/user.provider.dart';
import '../services/database.dart';
import '../widgets/loading.dart';
import 'next_profile_form_component.dart';

class MLLoginScreen extends StatefulWidget {
  static String tag = '/MLLoginScreen';

  const MLLoginScreen({Key? key}) : super(key: key);

  @override
  _MLLoginScreenState createState() => _MLLoginScreenState();
}

class _MLLoginScreenState extends State<MLLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;
  bool _isChecked = false;
  bool isSignupScreen = true;

  Future<bool> showExitPopup(context) async {
    var locale = AppLocalizations.of(context)!;
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text(locale.exitApp!),
        content: Text(locale.confirmExitApp!),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child: Text(locale.no!),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () {
              if (Platform.isAndroid) {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              } else if (Platform.isIOS) {
                exit(0);
              }
            },

            //return true when click on "Yes"
            child: Text(locale.yes!),
          ),
        ],
      ),
    );
  }

  void _handleRememberMe(bool? value) {
    _isChecked = value!;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var rememberMe = prefs.getBool("remember_me") ?? false;
      print(rememberMe);
      print(email);
      print(password);
      if (rememberMe) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = email;
        passwordController.text = password;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    init();
    super.initState();
  }

  Future<void> init() async {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<AppUser>(context);
    var locale = AppLocalizations.of(context)!;

    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: Text(locale.exitApp!),
              content: Text(locale.confirmExitApp!),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text(locale.no!),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },

                  //return true when click on "Yes"
                  child: Text(locale.yes!),
                ),
              ],
            ),
          ) ??
          false; //if showDialogue had returned null, then return false
    }

    return SafeArea(
        child: WillPopScope(
      onWillPop: () async => showExitPopup(),
      child: loading
          ? const Loading()
          : Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [kSecondaryColor, kPrimaryColor])),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 150),
                      height: context.height(),
                      decoration: boxDecorationWithRoundedCorners(
                          borderRadius: radiusOnly(topRight: 32)),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            60.height,
                            Center(
                              child: Text(locale.login!.toUpperCase(),
                                  style: boldTextStyle(size: 28)),
                            ),
                            36.height,
                            Row(
                              children: [
                                AppTextField(
                                  controller: emailController,
                                  textFieldType: TextFieldType.EMAIL,
                                  decoration: InputDecoration(
                                    labelText: locale.enterEmailAddress,
                                    labelStyle: secondaryTextStyle(size: 16),
                                    prefixIcon: const Icon(Icons.mail),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white30),
                                    ),
                                  ),
                                ).expand(),
                              ],
                            ),
                            16.height,
                            AppTextField(
                              controller: passwordController,
                              textFieldType: TextFieldType.PASSWORD,
                              decoration: InputDecoration(
                                labelText: locale.enterPassword,
                                labelStyle: secondaryTextStyle(size: 16),
                                prefixIcon: const Icon(Icons.lock_outline),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white30),
                                ),
                              ),
                            ),
                            20.height,
                            Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: 24.0,
                                          width: 24.0,
                                          child: Theme(
                                            data: ThemeData(
                                                unselectedWidgetColor:
                                                    kPrimaryColor // Your color
                                                ),
                                            child: Checkbox(
                                                activeColor: kPrimaryColor,
                                                value: _isChecked,
                                                onChanged:
                                                    emailController.text ==
                                                                '' ||
                                                            passwordController
                                                                    .text ==
                                                                ''
                                                        ? null
                                                        : _handleRememberMe),
                                          )),
                                      const SizedBox(width: 10.0),
                                      Text(locale.rememberMe!,
                                          style: secondaryTextStyle(size: 16)),
                                      const Spacer(),
                                      Text(locale.forgotPassword!,
                                          style: secondaryTextStyle(
                                            size: 16,
                                            color: const Color(0xFF003AFF),
                                          )).onTap(() {
                                        const ForgotPasswordPage()
                                            .launch(context);
                                      }),
                                    ])),
                            64.height,
                            AppButton(
                              color: kPrimaryColor,
                              width: double.infinity,
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });
                                try {
                                  //TODO : LOGIN
                                  await appUser.signIn(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  loading = false;
                                  if (appUser.user!.emailVerified) {
                                    var exist = await DatabaseService(
                                            uid: AppUser.instance.user!.uid)
                                        .checkData(AppUser.instance.user!.uid);
                                    print('data $exist');
                                    if (exist) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MLSplashScreenHadis()));
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NextProfileFormComponent()));
                                    }
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const VerifyScreen()));
                                  }
                                } catch (e) {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message: locale.error!,
                                    ),
                                  );
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    loading = false;
                                    _isChecked = false;
                                    preferences.remove(emailController.text);
                                    preferences.remove(passwordController.text);
                                  });
                                }
                              },
                              child: Text(locale.login!,
                                  style: boldTextStyle(color: black)),
                            ),
                            22.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  locale.dontHaveAnAccount!,
                                  style: primaryTextStyle(),
                                ),
                                8.width,
                                Text(
                                  locale.registerNow!,
                                  style: secondaryTextStyle(
                                      size: 16,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ).onTap(() {
                                  const RegisterPage().launch(context);
                                }),
                              ],
                            ),
                            32.height,
                          ],
                        ).paddingOnly(left: 16, right: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ));
  }
}
