import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:istiqamah_app/screen/email.screen.dart';
import 'package:istiqamah_app/screen/login_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../Locale/locales.dart';
import '../components/default_scaffold.dart';
import '../constants/constant.dart';
import '../models/user.model.dart';
import '../providers/user.provider.dart';
import '../widgets/loading.dart';

class RegisterPage extends StatefulWidget {
  static String tag = '/RegisterPage';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  int textLength = 0;
  int textLength2 = 0;

  bool validate = false;
  bool emailIsValid = false;
  bool nameIsValid = false;
  bool pass1IsValid = false;
  bool pass2IsValid = false;

  @override
  void initState() {
    if (mounted) {
      super.initState();
      init();
    }
  }

  Future<void> init() async {}

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final appUser = Provider.of<AppUser>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                    'Register now to begin',
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
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: 440,
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
                          onChanged: (e) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(e)) {
                              setState(() {
                                emailIsValid = true;
                              });
                            } else {
                              setState(() {
                                emailIsValid = false;
                              });
                            }
                          },
                          controller: _email,
                          textFieldType: TextFieldType.EMAIL,
                          autoFocus: false,
                          textStyle: textStyleNormal,
                          decoration: _textFieldDeco('Email'),
                          validator: (value) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value!)) {
                              return locale.emailHandling;
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                              visible: emailIsValid,
                              child: Text(
                                locale.emailHandling ?? '',
                                style: const TextStyle(color: Colors.redAccent),
                              )),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        //Name
                        AppTextField(
                          onChanged: (e) {
                            if (!RegExp(r"^[a-z A-Z,.\'-]+$").hasMatch(e)) {
                              setState(() {
                                nameIsValid = true;
                              });
                            } else {
                              setState(() {
                                nameIsValid = false;
                              });
                            }
                          },
                          controller: _name,
                          autoFocus: false,
                          textStyle: textStyleNormal,
                          decoration: _textFieldDeco('Full Name'),
                          textFieldType: TextFieldType.NAME,
                          validator: (value) {
                            if (!RegExp(r"^[a-z A-Z,.\'-]+$")
                                .hasMatch(value!)) {
                              return locale.fullnameHandling;
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                              visible: nameIsValid,
                              child: Text(
                                locale.fullnameHandling ?? '',
                                style: const TextStyle(color: Colors.redAccent),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //Password
                        AppTextField(
                          onChanged: (_pass) {
                            setState(() {
                              textLength = _pass.length;
                            });
                            if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                .hasMatch(_pass)) {
                              setState(() {
                                pass1IsValid = true;
                                validate = true;
                              });
                            } else {
                              setState(() {
                                pass1IsValid = false;
                                validate = false;
                              });
                            }
                          },
                          controller: _pass,
                          autoFocus: false,
                          textStyle: textStyleNormal,
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: _textFieldDeco('Password'),
                          validator: (value) {
                            if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                .hasMatch(_pass.text)) {
                              setState(() {
                                validate = true;
                              });
                              return locale.passwordHandling;
                            } else {
                              setState(() {
                                validate = false;
                              });
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                              visible: pass1IsValid,
                              child: Text(
                                locale.passwordHandling ?? '',
                                style: const TextStyle(color: Colors.redAccent),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        //Confirm password
                        AppTextField(
                          onChanged: (_pass2) {
                            setState(() {
                              textLength2 = _pass2.length;
                            });
                            if (_pass.text != _pass2 || _pass2 == '') {
                              setState(() {
                                pass2IsValid = true;
                              });
                            } else {
                              setState(() {
                                pass2IsValid = false;
                              });
                            }
                          },
                          controller: _pass2,
                          textFieldType: TextFieldType.PASSWORD,
                          autoFocus: false,
                          textStyle: textStyleNormal,
                          decoration: _textFieldDeco('Confirm Password'),
                          validator: (value) {
                            if (_pass.text != _pass2.text) {
                              return locale.repasswordHandling;
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Visibility(
                              visible: pass2IsValid,
                              child: Text(
                                locale.repasswordHandling ?? '',
                                style: const TextStyle(color: Colors.redAccent),
                              )),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        InkWell(
                          onTap: checkCredential()
                              ? null
                              : () async {
                                  if (emailIsValid == false &&
                                      nameIsValid == false &&
                                      pass1IsValid == false &&
                                      pass2IsValid == false) {
                                    try {
                                      await appUser.signUp(
                                          email: _email.text.trim(),
                                          password: _pass2.text.trim(),
                                          name: _name.text);
                                      setState(() {
                                        userData.email = _email.text;
                                        userData.password = _pass.text;
                                      });
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                          message: locale.emailSent!,
                                        ),
                                      );
                                      await const VerifyScreen()
                                          .launch(context);
                                    } catch (e) {
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                          message: locale.error!,
                                        ),
                                      );
                                    }
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
                            child: const Center(
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
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
                                  text: "Already Registered?",
                                  style: textStyleNormal,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' Login now!',
                                      style: const TextStyle(
                                          color: Color(0xFF003AFF),
                                          fontSize: 12),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(
                                                  context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MLLoginScreen()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                    ),
                                  ],
                                ),
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
                                  text: locale.helpdesk!,
                                  style: textStyleNormal,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: locale.sentEmail!,
                                      style: const TextStyle(
                                          color: Color(0xFF003AFF),
                                          fontSize: 12),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MLEmailScreen()),
                                          );
                                        },
                                    ),
                                  ],
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

  checkCredential() {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(_email.text) ||
        !RegExp(r"^[a-z A-Z,.\'-]+$").hasMatch(_name.text) ||
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
            .hasMatch(_pass.text) ||
        _pass.text != _pass2.text ||
        _pass2.text == '' ||
        _name.text == '') {
      return true;
    } else {
      return false;
    }
  }
}
