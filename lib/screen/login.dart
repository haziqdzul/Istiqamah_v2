import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:istiqamah_app/screen/forgot_page.dart';
import 'package:istiqamah_app/screen/register_page.dart';
import 'package:istiqamah_app/screen/splash.screen.hadis.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'dart:async';
import '../Locale/locales.dart';
import '../components/default_scaffold.dart';
import '../constants/constant.dart';
import '../providers/user.provider.dart';
import '../services/database.dart';
import '../widgets/loading.dart';
import 'next_profile_form_component.dart';

class LoginPage extends StatefulWidget {
  static String tag = '/LoginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _rememberMe = _prefs.getBool("remember_me") ?? false;
      print(_rememberMe);
      print(_email);
      print(_password);
      if (_rememberMe) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = _email;
        passwordController.text = _password;
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
    var locale = AppLocalizations.of(context)!;
    final appUser = Provider.of<AppUser>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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

    return DefaultBody(
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SafeArea(
          top: false,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome !',
                    style: TextStyle(
                        fontSize: 35,
                        color: Color(0xFFD0A22A),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Login to continue',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFFD0A22A),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 90),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 340,
                      width: width - 80,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/settings_msc.png',
                            width: 150,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        //email
                        AppTextField(
                          controller: emailController,
                          textFieldType: TextFieldType.EMAIL,
                          autoFocus: false,
                          textStyle: textStyleNormal,
                          decoration: _textFieldDeco('Email'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //Password
                        AppTextField(
                          controller: passwordController,
                          autoFocus: false,
                          textStyle: textStyleNormal,
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: _textFieldDeco('Password'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        InkWell(
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MLSplashScreenHadis()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NextProfileFormComponent()));
                                }
                              } else {
                                Navigator.push(
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

                          child: Container(
                            width: width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: kPrimaryColor,
                            ),
                            child: Center(
                              child: Text(
                                locale.login!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          // child: Text(locale.register!,
                          //     style: boldTextStyle(color: black)),
                        ),

                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: locale.registerNow!,
                                    style: const TextStyle(
                                        color: Color(0xFF003AFF), fontSize: 12),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(
                                                context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegisterPage()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      }),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 20),
                          child: Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: locale.forgotPassword!,
                                  style: const TextStyle(
                                      color: Color(0xFF003AFF), fontSize: 12),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPasswordPage()),
                                      );
                                    },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _textFieldDeco(hint) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF6F6F1),
      contentPadding: const EdgeInsets.only(left: 20.0, bottom: 6.0, top: 8.0),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFFF6F6F1),
        ),
        borderRadius: BorderRadius.circular(40.0),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xFFF6F6F1),
        ),
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }
}
