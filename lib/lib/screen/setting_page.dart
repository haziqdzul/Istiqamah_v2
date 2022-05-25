import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istiqamah_app/components/alert_button.dart';
import 'package:istiqamah_app/components/corner_body.dart';
import 'package:istiqamah_app/constants/constant.dart';
import 'package:provider/provider.dart';
import '../providers/languages.provider.dart';
import '../widgets/language_cubit.dart';

enum Language { bm, english }

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late LanguageCubit _languageCubit;
  bool _switch = false;

  Language? selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return CornerBody(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Setting',
                style: textStyleBold,
              ),
              Icon(
                Icons.more_vert,
                size: 20,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                // const Text(
                //   'Location',
                //   style: textStyleBold,
                // ),
                // Transform.scale(
                //   transformHitTests: false,
                //   scale: .6,
                //   child: CupertinoSwitch(
                //     value: _switch,
                //     onChanged: (value) {
                //       setState(() {
                //         _switch = value;
                //       });
                //     },
                //     activeColor: Colors.green,
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Language',
                  style: textStyleBold,
                ),
                const SizedBox(
                  height: 25,
                ),
                DefaultButton(
                  label: 'Bahasa Melayu',
                  textStyle: textStyleNormal,
                  decoration: BoxDecoration(
                      color: selectedLanguage == Language.bm
                          ? kPrimaryColor
                          : kGreyColor,
                      borderRadius: BorderRadius.circular(16)),
                  onPress: () {
                    var box = GetStorage();
                    box.write('lang', 'id');
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLocale('My');
                    _languageCubit.selectIndonesianLanguage();

                    setState(() {
                      selectedLanguage = Language.bm;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                DefaultButton(
                  label: 'English',
                  textStyle: textStyleNormal,
                  decoration: BoxDecoration(
                      color: selectedLanguage == Language.english
                          ? kPrimaryColor
                          : kGreyColor,
                      borderRadius: BorderRadius.circular(16)),
                  onPress: () {
                    var box = GetStorage();
                    box.write('lang', 'en');
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLocale('En');
                    _languageCubit.selectEngLanguage();

                    setState(() {
                      selectedLanguage = Language.english;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
