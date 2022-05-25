import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../Locale/locales.dart';
import '../components/default_scaffold.dart';
import '../constants/constant.dart';

class ForgotPasswordPage extends StatefulWidget {
  static String tag = '/ForgotPasswordPage';

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }
  Future<void> init() async {
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double appbarSize = AppBar().preferredSize.height;
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
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                margin: EdgeInsets.only(top: (width / 2) - appbarSize),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locale.resetPassword!, style: boldTextStyle(size: 24)),
                    const SizedBox(height: 10,),
                    Text(locale.resetPasswordDesc!, style: secondaryTextStyle()),
                    const SizedBox(height: 30,),

                    AppTextField(
                      controller: _emailController,
                      textFieldType: TextFieldType.EMAIL,
                      autoFocus: false,
                      decoration: _textFieldDeco('Email'),
                    ),

                    InkWell(
                      onTap: () {
                        if (_emailController.value.text != '' &&
                            _emailController.text.length > 7) {
                          resetPassword(_emailController.text.trim());
                          Fluttertoast.showToast(msg: locale.resetPasswordSent!);
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(msg: locale.inputCorrectEmail!);
                        }
                      },
                      child: Container(
                        width: width,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 50, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: kPrimaryColor,
                        ),

                        child: Center(
                          child: Text(
                            locale.submit!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
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

  void resetPassword(String email) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: email);
  }
}
