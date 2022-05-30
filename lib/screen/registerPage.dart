import 'package:flutter/material.dart';
import 'package:istiqamah_app/constants/constant.dart';
import 'package:istiqamah_app/screen/login_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../Locale/locales.dart';
import '../Utils/MLColors.dart';
import '../Utils/common.dart';
import '../constants/constant.dart';
import '../models/user.model.dart';
import '../providers/user.provider.dart';
import '../widgets/loading.dart';
import 'email.screen.dart';

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
  bool validate = false;
  int textLength = 0;
  int textLength2 = 0;

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

  Future<void> init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final appUser = Provider.of<AppUser>(context);

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [kSecondaryColor, kPrimaryColor])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 150),
                padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radiusOnly(topRight: 32)),
                height: context.height(),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        40.height,
                        Text(locale.register!, style: boldTextStyle(size: 28)),
                        8.height,
                        Text(locale.registerToContinue!,
                            style: secondaryTextStyle(size: 16)),
                        8.height,
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
                          decoration: InputDecoration(
                            labelText: locale.enterEmailAddress,
                            labelStyle: secondaryTextStyle(size: 16),
                            prefixIcon: const Icon(Icons.mail),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mlColorLightGrey),
                            ),
                          ),
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
                        8.height,
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
                          decoration: InputDecoration(
                            hintText: locale.enterFullName,
                            hintStyle: secondaryTextStyle(size: 16),
                            prefixIcon: const Icon(Icons.person),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mlColorLightGrey),
                            ),
                          ),
                          textFieldType: TextFieldType.NAME,
                          // validator: (value) {
                          //   if (!RegExp(r"^[a-z A-Z,.\'-]+$")
                          //       .hasMatch(value!)) {
                          //     return locale.fullnameHandling;
                          //   } else {
                          //     return null;
                          //   }
                          // },
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
                        8.height,
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
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: InputDecoration(
                            labelText: locale.enterPassword,
                            labelStyle: secondaryTextStyle(size: 16),
                            prefixIcon: Icon(
                              !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                      .hasMatch(_pass.text)
                                  ? Icons.lock_outline
                                  : Icons.check,
                              color:
                                  !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                          .hasMatch(_pass.text)
                                      ? Colors.grey
                                      : Colors.green,
                              size: 20,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                              .hasMatch(_pass.text)
                                          ? mlColorLightGrey
                                          : Colors.green),
                            ),
                          ),
                          // validator: (value) {
                          //   if (!RegExp(
                          //           r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                          //       .hasMatch(_pass.text)) {
                          //     setState(() {
                          //       validate = true;
                          //     });
                          //     return locale.passwordHandling;
                          //   } else {
                          //     setState(() {
                          //       validate = false;
                          //     });
                          //     return null;
                          //   }
                          // },
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
                        8.height,
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
                          decoration: InputDecoration(
                            labelText: locale.reenterPassword!,
                            labelStyle: secondaryTextStyle(size: 16),
                            prefixIcon: Icon(
                                checkPass() ? Icons.check : Icons.lock_outline,
                                color: checkPass() ? Colors.green : Colors.grey,
                                size: 20),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: textLength2 > 7
                                      ? Colors.green
                                      : mlColorLightGrey),
                            ),
                          ),
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
                        8.height,
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                  ),
                                  onPressed: checkCredential()
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
                                  child: Text(locale.register!,
                                      style: boldTextStyle(color: black)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        8.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              locale.haveAnAccount!,
                              style: primaryTextStyle(),
                            ),
                            8.width,
                            Text(
                              locale.loginNow!,
                              style: secondaryTextStyle(
                                  size: 16,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ).onTap(() {
                              const MLLoginScreen().launch(context);
                            }),
                          ],
                        ),
                        8.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              locale.helpdesk!,
                              style: primaryTextStyle(),
                            ),
                            8.width,
                            Text(
                              locale.sentEmail!,
                              style: secondaryTextStyle(
                                  size: 16,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ).onTap(() {
                              const MLEmailScreen().launch(context);
                            }),
                          ],
                        ),
                        8.height,
                      ],
                    ),
                  ),
                ),
              ),
              22.height,
              Positioned(
                top: 30,
                child: mlBackToPrevious(context, blackColor),
              ),
            ],
          ).center(),
        ),
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

  checkPass() {
    if (textLength2 > 7 && _pass.text == _pass2.text) {
      return true;
    } else {
      return false;
    }
  }
}
