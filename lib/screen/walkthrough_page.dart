import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istiqamah_app/screen/login_page.dart';
import 'package:istiqamah_app/screen/registerPage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Locale/locales.dart';
import '../providers/languages.provider.dart';
import '../widgets/language_cubit.dart';

class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({Key? key}) : super(key: key);

  @override
  State<WalkthroughPage> createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage> {
  late LanguageCubit _languageCubit;
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    var locale = AppLocalizations.of(context)!;
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          onTap: null,
          value: "",
          child: Text(locale.selectLanguage!,
              style: boldTextStyle(size: 15, color: Colors.white))),
      DropdownMenuItem(
          onTap: () {
            var box = GetStorage();
            box.write('lang', 'en');
            Provider.of<LanguageProvider>(context, listen: false)
                .changeLocale('En');
            _languageCubit.selectEngLanguage();
          },
          value: "en",
          child: Text("English",
              style: boldTextStyle(size: 15, color: Colors.white))),
      DropdownMenuItem(
          onTap: () {
            var box = GetStorage();
            box.write('lang', 'id');
            Provider.of<LanguageProvider>(context, listen: false)
                .changeLocale('My');
            _languageCubit.selectIndonesianLanguage();
          },
          value: "id",
          child: Text("Bahasa Malaysia",
              style: boldTextStyle(size: 15, color: Colors.white))),
    ];
    return menuItems;
  }

  String selectedValue = "";

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.amber,
        body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            SizedBox(
              child: Stack(children: [
                Positioned(
                  //top: 0,
                  child: Container(
                    height: height * 0.55,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/wt1.png"),
                            fit: BoxFit.cover),
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(530))),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          WalkthroughTitleBody(
                            title: locale.asSunnahApp,
                            body: locale.usingTechnology,
                          ),
                          Center(
                            child: Container(
                              width: 100,
                              height: 50,
                              margin:
                                  const EdgeInsets.only(top: 60, bottom: 30),
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(35),
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
              ]),
            ),
            SizedBox(
              child: Stack(children: [
                Positioned(
                  //top: 0,
                  child: Container(
                    height: height * 0.55,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/wt2.png"),
                            fit: BoxFit.cover),
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(530))),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          WalkthroughTitleBody(
                              title: locale.hadith,
                              body: locale.hadithNarrated),
                          Center(
                            child: Container(
                              width: 100,
                              height: 50,
                              margin:
                                  const EdgeInsets.only(top: 60, bottom: 30),
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(35),
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
              ]),
            ),
            SizedBox(
              child: Stack(children: [
                Positioned(
                  //top: 0,
                  child: Container(
                    height: height * 0.55,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/wt3.png"),
                            fit: BoxFit.cover),
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(530))),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          WalkthroughTitleBody(
                              title: locale.letgetstarted,
                              body: locale.letgetstartedmessage),
                          Center(
                            child: Container(
                              width: 100,
                              height: 50,
                              margin:
                                  const EdgeInsets.only(top: 60, bottom: 30),
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(35),
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
              ]),
            ),
          ],
        ),
        bottomSheet: isLastPage
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                color: Colors.amber,
                height: 80,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WalkButton(
                          onPress: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MLLoginScreen()),
                                (Route<dynamic> route) => false);
                          },
                          label: locale.skip!,
                        ),
                        Center(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: const SwapEffect(
                                spacing: 10,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.white),
                            onDotClicked: (index) => controller.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn),
                          ),
                        ),
                        WalkButton(
                          onPress: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const RegisterPage()),
                                (Route<dynamic> route) => false);
                          },
                          label: locale.getStarted!,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                ))
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                color: Colors.amber,
                height: 80,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WalkButton(
                          onPress: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MLLoginScreen()),
                                (Route<dynamic> route) => false);
                          },
                          label: locale.skip!,
                        ),
                        Center(
                          child: SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: const SwapEffect(
                                spacing: 10,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.white),
                            onDotClicked: (index) => controller.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn),
                          ),
                        ),
                        WalkButton(
                          onPress: () => controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut),
                          label: locale.next!,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                )));
  }
}

class WalkthroughTitleBody extends StatelessWidget {
  const WalkthroughTitleBody({this.title, this.body});

  final String? title;
  final String? body;

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
              title!,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 50),
          child: Text(
            body!,
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
        width: 100,
        padding: const EdgeInsets.all(10),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
