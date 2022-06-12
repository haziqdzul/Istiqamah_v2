import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:istiqamah_app/models/user.model.dart' as us;
import 'package:istiqamah_app/screen/splash.screen.hadis.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../Locale/locales.dart';
import '../providers/user.provider.dart';
import '../services/database.dart';
import '../widgets/colors.dart';
import '../widgets/loading.dart';
import 'next_profile_form_component.dart';

class NextUpdateProfileScreen extends StatefulWidget {
  final String gender;
  final String title;
  final String dob;
  final String country;
  final String state;
  final String city;
  final String postcode;
  final String address1;
  final String address2;
  final String address3;
  final String phoneNo;

  const NextUpdateProfileScreen(
      this.gender,
      this.title,
      this.dob,
      this.country,
      this.city,
      this.state,
      this.postcode,
      this.address1,
      this.address2,
      this.address3,
      this.phoneNo,
      {Key? key})
      : super(key: key);

  @override
  _NextUpdateProfileScreenState createState() =>
      _NextUpdateProfileScreenState();
}

class _NextUpdateProfileScreenState extends State<NextUpdateProfileScreen> {
  final user = AppUser().user;
  // FirebaseAuth auth = FirebaseAuth.instance;
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Widget closebutton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(390, 40), primary: const Color(0xFFFFE080)),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        locale.close ?? '',
        style: const TextStyle(color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
    return loading
        ? const Loading()
        : Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFE080), Color(0xFFCB5F00)])),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Container(
                    decoration: boxDecorationWithRoundedCorners(
                        borderRadius: radiusOnly(topRight: 32)),
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(locale.updateYourInformation!,
                                style: boldTextStyle(size: 24)),
                            const NextProfileFormComponent(),
                            Row(
                              children: [
                                Checkbox(
                                  value: _enabled,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _enabled = value ?? true;
                                    });
                                  },
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        text: locale.termText!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        children: [
                                          const TextSpan(text: ' '),
                                          TextSpan(
                                              text: "${locale.termCondition!} ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        scrollable: true,
                                                        content: Column(
                                                          children: [
                                                            Text(locale.term1!,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(locale.term2!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(locale.term3!,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(locale.term4!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.term5!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(locale.term6!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                          ],
                                                        ),
                                                        actions: [
                                                          closebutton,
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }),
                                          TextSpan(text: "${locale.and!} "),
                                          TextSpan(
                                              text: "${locale.privacyPolicy!} ",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        scrollable: true,
                                                        content: Column(
                                                          children: [
                                                            Text(
                                                                locale
                                                                    .privacy1!,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Text(
                                                                locale
                                                                    .privacy2!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy3!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy4!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy5!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy6!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy7!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy8!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy9!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy10!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy11!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy12!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy13!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy14!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy15!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy16!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy17!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy18!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            Text(
                                                              locale.privacy19!,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                                locale
                                                                    .privacy20!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                          ],
                                                        ),
                                                        actions: [
                                                          closebutton,
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Positioned(top: 45, child: mlBackToPrevious(context, blackColor)),
                  Positioned(
                    bottom: 8,
                    left: 16,
                    right: 16,
                    child: (_enabled)
                        ? AppButton(
                            height: 50,
                            width: context.width(),
                            color: ManyColors.textColor2,
                            onTap: () async {
                              setState(() {
                                loading = true;
                              });
                              if (us.userData.phoneNo != null) {
                                await DatabaseService(
                                        uid: AppUser.instance.user!.uid)
                                    .userData(
                                  us.userData.gender ?? widget.gender,
                                  us.userData.title ?? widget.title,
                                  us.userData.dob ?? widget.dob,
                                  us.userData.country ?? widget.country,
                                  us.userData.state ?? widget.state,
                                  us.userData.city ?? widget.city,
                                  us.userData.postcode ?? widget.postcode,
                                  us.userData.address1 ?? widget.address1,
                                  us.userData.address2 ?? widget.address2,
                                  us.userData.address3 ?? widget.address3,
                                  us.userData.ethnicity ?? 'No data',
                                  widget.phoneNo,
                                  us.userData.height ?? 'No data',
                                  us.userData.weight ?? 'No data',
                                  us.userData.bmi ?? 'No data',
                                );
                                setState(() {
                                  loading = false;
                                });
                                const MLSplashScreenHadis().launch(context);
                              } else {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message: locale.fillAllInformation!,
                                  ),
                                );
                                setState(() {
                                  loading = false;
                                });
                              }
                            },
                            child: Text(locale.save!,
                                style: boldTextStyle(color: black)),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          );
  }
}
