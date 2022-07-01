import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Locale/locales.dart';
import '../providers/user.provider.dart';
import '../screen/email.screen.dart';
import '../screen/next_profile_form_component.dart';
import '../widgets/bullet.widget.dart';
import '../widgets/language_cubit.dart';

class MLProfileBottomComponent extends StatefulWidget {
  static String tag = '/MLProfileBottomComponent';

  const MLProfileBottomComponent({Key? key}) : super(key: key);

  @override
  MLProfileBottomComponentState createState() =>
      MLProfileBottomComponentState();
}

class MLProfileBottomComponentState extends State<MLProfileBottomComponent> {
  List<String> data = <String>[
    'Membership card',
    'Dependents',
    'Health care',
    'Logout'
  ];
  List<String> categoriesData = <String>[
    'Prescription',
    'Medical Record',
    'Medical Test',
    'Health Tracking'
  ];
  List<Color> customColor = <Color>[
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.cyan
  ];
  //List<MLProfileCardData> mlProfileData = mlProfileDataList();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var _height;
  var _weight;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .get()
        .then((value) {
      setState(() {
        _height = value['height'];
        _weight = value['weight'];
      });
    }).catchError((e) {
      _height = '';
      _weight = '';
    });
    print(_height);
    print(_weight);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: boxDecorationWithRoundedCorners(
            borderRadius: radiusOnly(topRight: 32)),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(locale.setting_profile!, style: boldTextStyle(size: 18)),
              Text('', style: secondaryTextStyle(size: 18)),
            ],
          ),
          16.height,
          Column(children: [
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(30),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 24, color: Colors.blue),
                    8.width,
                    Text(locale.update_profile!,
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.blue, size: 16),
                  ],
                ),
              ),
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const NextProfileFormComponent()));
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(30),
                child: Row(
                  children: [
                    const Icon(Icons.info, size: 24, color: Colors.blue),
                    8.width,
                    Text(locale.aboutUs_profile!,
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.blue, size: 16),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsScreen()));
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(30),
                child: Row(
                  children: [
                    const Icon(Icons.language, size: 24, color: Colors.blue),
                    8.width,
                    Text(locale.language_profile!,
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.blue, size: 16),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LanguageScreen()));
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(30),
                child: Row(
                  children: [
                    const Icon(Icons.volunteer_activism,
                        size: 24, color: Colors.blue),
                    8.width,
                    Text(locale.Acknowledgement_profile!,
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.blue, size: 16),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AcknowledgementScreen()));
              },
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                padding: const EdgeInsets.all(12.0),
                decoration: boxDecorationRoundedWithShadow(30),
                child: Row(
                  children: [
                    const Icon(Icons.live_help, size: 24, color: Colors.blue),
                    8.width,
                    Text(locale.helpdesk!,
                            style: secondaryTextStyle(color: black, size: 16))
                        .expand(),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.blue, size: 16),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MLEmailScreen()));
              },
            ),
          ])
        ]));
  }

  Future<void> update(String weight, String height) {
    return users
        // existing document in 'users' collection: "ABC123"
        .doc(AppUser.instance.user!.uid)
        .set(
          {
            'weight': weight,
            'height': height,
          },
          SetOptions(merge: true),
        )
        .then((value) => print("'weight' merged with existing data!"))
        .catchError((error) => print("Failed to merge data: $error"));
  }
}

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/app_coming_soon2.jpg'),
                  fit: BoxFit.fill),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  locale.aboutUs_profile!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ).paddingOnly(left: 12, right: 12),
                30.height,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width / 4,
                          height: 170,
                          child: Text(
                            locale.aboutUs!,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                (locale.aboutUs_profile! == 'About Us')
                    ? Container(
                        height: 150.0,
                        width: 350.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Logo As-sunnah_transparentbg-02.png'),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      )
                    : Container(
                        height: 150.0,
                        width: 350.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/Logo As-Sunnah_Malay_TPBG-03.png'),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                130.height,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: locale.visitour_profile!,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => launch('http://as-sunnah.com/'),
                          text: locale.website_profile!,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: locale.fmi_profile!,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black))
                    ]),
                  ),
                ),
                50.height,
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            mini: true,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.arrow_back,
              color: black,
            ),
          ).paddingOnly(right: 16, left: 16, top: 71, bottom: 8),
        ],
      ),
    );
  }
}

class AcknowledgementScreen extends StatefulWidget {
  const AcknowledgementScreen({Key? key}) : super(key: key);

  @override
  _AcknowledgementScreenState createState() => _AcknowledgementScreenState();
}

class _AcknowledgementScreenState extends State<AcknowledgementScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/app_coming_soon2.jpg'),
                    fit: BoxFit.fill),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    locale.Acknowledgement_profile!,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ).paddingOnly(left: 12, right: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (locale.Acknowledgement_profile! == 'Acknowledgement')
                          ? Container(
                              height: 130.0,
                              width: 180.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/Logo As-sunnah_transparentbg-02.png'),
                                ),
                              ),
                            )
                          : Container(
                              height: 130.0,
                              width: 180.0,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/Logo As-Sunnah_Malay_TPBG-03.png'),
                                ),
                              ),
                            ),
                      Container(
                        height: 130.0,
                        width: 180.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/uitm-universiti-teknologi-mara-logo.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Text(
                      locale.Acknowledgement_text!,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: UnorderedList([
                      locale.Acknowledgement_text1!,
                      locale.Acknowledgement_text2!,
                      locale.Acknowledgement_text3!,
                      locale.Acknowledgement_text4!,
                      locale.Acknowledgement_text5!,
                      locale.Acknowledgement_text6!,
                    ]),
                  ),
                ],
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              mini: true,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.arrow_back,
                color: black,
              ),
            ).paddingOnly(right: 16, left: 16, top: 71, bottom: 8),
          ],
        ),
      ),
    );
  }
}

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  late LanguageCubit _languageCubit;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  locale.language_profile!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ).paddingOnly(left: 12, right: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: boxDecorationRoundedWithShadow(30),
                          child: Row(
                            children: [
                              Text(
                                '   Bahasa Malaysia',
                                style: boldTextStyle(size: 15),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          var box = GetStorage();
                          box.write('lang', 'id');
                          _languageCubit.selectIndonesianLanguage();
                          Navigator.pop(context);
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: boxDecorationRoundedWithShadow(30),
                          child: Row(
                            children: [
                              Text(
                                '   English',
                                style: boldTextStyle(size: 15),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          var box = GetStorage();
                          box.write('lang', 'en');
                          _languageCubit.selectEngLanguage();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            mini: true,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.arrow_back,
              color: black,
            ),
          ).paddingOnly(right: 16, left: 16, top: 71, bottom: 8),
        ],
      ),
    );
  }
}
