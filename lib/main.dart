import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:istiqamah_app/constants/constant.dart';
import 'package:istiqamah_app/providers/cancel.notification.provider.dart';
import 'package:istiqamah_app/providers/languages.provider.dart';
import 'package:istiqamah_app/providers/medicine1.provider.dart';
import 'package:istiqamah_app/providers/medicine2.provider.dart';
import 'package:istiqamah_app/providers/profile.provider.dart';
import 'package:istiqamah_app/providers/user.provider.dart';
import 'package:istiqamah_app/providers/water.provider.dart';
import 'package:istiqamah_app/widgets/language_cubit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'Locale/locales.dart';
import 'Routes/routes.dart';
import 'screen/walkthrough_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await notificationInit();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  //await NotificationService().init();
  // await NotificationService().requestIOSPermissions(); //
  runApp(Phoenix(child: const MyApp()));
  //endregion
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appUser = AppUser();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppUser>.value(value: appUser),
        ChangeNotifierProvider<WaterProvider>(
            create: (context) => WaterProvider()),
        ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider()),
        ChangeNotifierProvider<Medicine1Provider>(
            create: (context) => Medicine1Provider()),
        ChangeNotifierProvider<Medicine2Provider>(
            create: (context) => Medicine2Provider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (context) => ProfileProvider()),
        ChangeNotifierProvider<CancelNotificationProvider>(
            create: (context) => CancelNotificationProvider())
      ],
      child: BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
          child: BlocBuilder<LanguageCubit, Locale>(builder: (_, locale) {
            return FeatureDiscovery(
              child: MaterialApp(
                theme: ThemeData(
                  fontFamily: 'lato',
                ),
                debugShowCheckedModeBanner: false,
                title: 'Istiqamah',
                //home: const SplashScreen(),
                home: locale.languageCode != 'en'
                    ? const SplashScreen()
                    : const SplashScreen(),
                themeMode: ThemeMode.light,
                // theme: !appStore.isDarkModeOn
                //     ? AppThemeData.lightTheme
                //     : AppThemeData.darkTheme,
                // routes: routes(),
                navigatorKey: navigatorKey,
                scrollBehavior: SBehavior(),
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                  Locale('pt'),
                  Locale('fr'),
                  Locale('id'),
                  Locale('es'),
                  Locale('tk'),
                  Locale('it'),
                  Locale('sw'),
                  // Locale('ms'),
                ],
                locale: locale,
                routes: PageRoutes().routes(),
              ),
            );
          })),
    );
  }
}

Future<void> notificationInit() async {
  await AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
    null,
    [
      NotificationChannel(
        channelKey: 'medicine1_channel',
        channelName: 'Medicine Notifications',
        defaultColor: Colors.yellow,
        ledColor: Colors.white,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Medicine Notification channel',
      ),
      NotificationChannel(
        channelKey: 'medicine2_channel',
        channelName: 'Medicine Notifications',
        defaultColor: Colors.yellow,
        ledColor: Colors.white,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Medicine Notification channel',
      ),
      NotificationChannel(
        channelKey: 'product_channel',
        channelName: 'Product Notifications',
        defaultColor: Colors.yellow,
        ledColor: Colors.white,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Product Notification channel',
      ),
      NotificationChannel(
        channelKey: 'water_channel',
        channelName: 'Water Notifications',
        defaultColor: Colors.yellow,
        ledColor: Colors.white,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Water reminder daily',
      ),
      NotificationChannel(
        channelKey: 'sadaqah_channel',
        channelName: 'Sadaqah Notifications',
        defaultColor: Colors.yellow,
        ledColor: Colors.white,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Sadaqah reminder daily',
      ),
      NotificationChannel(
        channelKey: 'tahajjud_channel',
        channelName: 'Tahajjud Notifications',
        defaultColor: Colors.yellow,
        ledColor: Colors.white,
        locked: true,
        importance: NotificationImportance.High,
        channelDescription: 'Tahajjud reminder daily',
      ),
    ],
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _visible = false;
      });
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const WalktroughPage()),
            (Route<dynamic> route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: _visible ? Colors.white : kPrimaryColor.withOpacity(0.2),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: AnimatedOpacity(
                  opacity: _visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Image.asset(
                    'assets/bottom_cloud.png',
                    fit: BoxFit.cover,
                  ),
                )),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo_istiqamah.png',
                    // width: 500,
                    height: 150,
                    // fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'ISTIQAMAH',
                    style: TextStyle(
                        color: Color(0xFFD0A22A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
