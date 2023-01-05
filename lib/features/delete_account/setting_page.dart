import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istiqamah_app/components/alert_button.dart';
import 'package:istiqamah_app/components/corner_body.dart';
import 'package:istiqamah_app/constants/constant.dart';
import 'package:istiqamah_app/providers/user.provider.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../Locale/locales.dart';
import '../../providers/languages.provider.dart';
import '../../widgets/language_cubit.dart';

enum Language { bm, english }

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late LanguageCubit _languageCubit;
  Language? selectedLanguage;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var user = Provider.of<AppUser>(context);
    return CornerBody(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                locale.setting_profile!,
                style: textStyleBold,
              ),
              // const Icon(
              //   Icons.more_vert,
              //   size: 20,
              // ),
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
                Text(
                  locale.selectLanguage!,
                  style: textStyleBold,
                ),
                const SizedBox(
                  height: 25,
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
                    box.write('lang', 'En');
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLocale('En');
                    _languageCubit.selectEngLanguage();
                    setState(() {
                      selectedLanguage = Language.english;
                    });
                  },
                  value: "en",
                ),
                const SizedBox(
                  height: 10,
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
                    box.write('lang', 'My');
                    Provider.of<LanguageProvider>(context, listen: false)
                        .changeLocale('My');
                    _languageCubit.selectIndonesianLanguage();
                    setState(() {
                      selectedLanguage = Language.bm;
                    });
                  },
                  value: "id",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.accountData!,
                  style: textStyleBold,
                ),
                const SizedBox(
                  height: 25,
                ),
                DefaultButton(
                  label: locale.deleteAccount!,
                  textStyle: textStyleNormal,
                  decoration: BoxDecoration(
                      color: kGreyColor,
                      borderRadius: BorderRadius.circular(16)),
                  onPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            actions: [
                              ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent),
                                  child: Text(locale.cancel!)),
                              ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      var data = await Navigator.pushNamed(
                                          context, 'reauth');
                                      if (data != null) {
                                        var credential = data as UserCredential;
                                        if (credential.user != null) {
                                          await user.backupCurrentProfile();
                                          await user.deleteProfile();
                                          await user.deleteAccount();
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                          user.logOut(context);
                                        }
                                      } else {
                                        if (!mounted) return;
                                        Navigator.pop(context);

                                        _showSnackBar(
                                          context,
                                          'User cancel delete account',
                                        );
                                      }
                                    } catch (e) {
                                      if (mounted) {
                                        Navigator.pop(context);
                                        _showSnackBar(
                                          context,
                                          e.toString(),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: const Text('OK')),
                            ],
                            title: Text(locale.deleteAccount!),
                            content: Text(locale.confirmToDelete!));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
