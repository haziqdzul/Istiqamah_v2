import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istiqamah_app/constants/constant.dart';
import 'package:istiqamah_app/screen/login_page.dart';
import 'package:istiqamah_app/screen/register_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Locale/locales.dart';
import '../providers/languages.provider.dart';
import '../widgets/language_cubit.dart';

class WalktroughPage extends StatefulWidget {
  const WalktroughPage({Key? key}) : super(key: key);

  @override
  State<WalktroughPage> createState() => _WalktroughPageState();
}

class _WalktroughPageState extends State<WalktroughPage> {
  int _progress = 0;
  int currentIndex = 0;
  late LanguageCubit _languageCubit;
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
    controller.addListener(() {
      if (controller.page!.round() != currentIndex) {
        setState(() {
          currentIndex = controller.page!.round();
        });
      }
    });
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    var locale = AppLocalizations.of(context)!;
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          onTap: null,
          child: Text(locale.selectLanguage!,
              style: boldTextStyle(size: 15, color: Colors.white)),
          value: ""),
      DropdownMenuItem(
          onTap: () {
            var box = GetStorage();
            box.write('lang', 'en');
            Provider.of<LanguageProvider>(context, listen: false)
                .changeLocale('En');
            _languageCubit.selectEngLanguage();
          },
          child: Text("English",
              style: boldTextStyle(size: 15, color: Colors.white)),
          value: "en"),
      DropdownMenuItem(
          onTap: () {
            var box = GetStorage();
            box.write('lang', 'id');
            Provider.of<LanguageProvider>(context, listen: false)
                .changeLocale('My');
            _languageCubit.selectIndonesianLanguage();
          },
          child: Text("Bahasa Malaysia",
              style: boldTextStyle(size: 15, color: Colors.white)),
          value: "id"),
    ];
    return menuItems;
  }

  String selectedValue = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: width,
            height: height,
            child: Stack(children: [
              Positioned(
                  top: 0,
                  child: Stack(
                    children: [
                      SafeArea(
                        child: Image.asset(
                          'assets/wt${_progress + 1}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 0,
                  child: Stack(
                    children: [
                      Image.asset('assets/walkthrough_cloud.png'),
                    ],
                  )),
              Positioned(
                  bottom: 0,
                  child: SafeArea(
                    child: Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          if (_progress == 0)
                            const WalkthroughTitleBody(
                              title: 'Istiqamah App',
                              body:
                                  'As-Sunnah uses the latest innovations, science and technology to make it easier for Muslims around the world topractice sunnah in istigamah.',
                            ),
                          if (_progress == 1)
                            const WalkthroughTitleBody(
                                title: 'Living The Sunnah',
                                body:
                                    'Whoever revives my sunnah then he has loved me. And whoever loves me. He shall be with me in paradise. [Hadith narrated by Al-Tarmizi (2678)]'),
                          if (_progress == 2)
                            const WalkthroughTitleBody(
                                title: "Let's Get Start",
                                body:
                                    "For first time users, let 'Register' by creating your account."),
                          Center(
                            child: Container(
                              width: 100,
                              height: 50,
                              margin:
                                  const EdgeInsets.only(top: 60, bottom: 30),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: [
                                        CircleProgress(
                                          color: _progress == index
                                              ? Colors.white
                                              : null,
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ),
                          _progress != 2
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    WalkButton(
                                      onPress: () {
                                        Navigator.of(
                                                context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MLLoginScreen()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                      label: 'Skip',
                                    ),
                                    WalkButton(
                                      onPress: () {
                                        setState(() {
                                          _progress = _progress + 1;
                                        });
                                      },
                                      label: 'Next',
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    WalkButton(
                                      onPress: () {
                                        Navigator.of(
                                                context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegisterPage()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                      label: 'Register',
                                      color: Colors.white,
                                    ),
                                    WalkButton(
                                      onPress: () {
                                        Navigator.of(
                                                context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MLLoginScreen()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                      label: 'Login',
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: DropdownButton(
                      dropdownColor: Colors.grey,
                      underline: Container(),
                      elevation: 2,
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems),
                ),
              ),
            ])),
      ),
    );
  }
}

class WalkthroughTitleBody extends StatelessWidget {
  const WalkthroughTitleBody({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 200,
            margin: const EdgeInsets.only(right: 0),
            child: Text(
              title,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 38,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 80),
          child: Text(
            body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class CircleProgress extends StatelessWidget {
  CircleProgress({Key? key, this.color}) : super(key: key);

  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kGreyColor, width: 2),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

class WalkButton extends StatelessWidget {
  WalkButton({Key? key, required this.label, this.onPress, this.color})
      : super(key: key);
  final String label;
  VoidCallback? onPress;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        width: 125,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(16)),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
