import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tyme/UI/pages/HomePage.dart';
import 'package:tyme/UI/pages/OnBoardingScreen.dart';
import 'package:tyme/UI/pages/QuoteFrontPage.dart';

import 'package:tyme/database/database.dart';
import 'package:tyme/utils/AppLocalizations.dart';
import 'package:tyme/utils/global_vars.dart';
import 'package:tyme/utils/konstants.dart';

import 'package:tyme/utils/local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  isUserNew().then((value) => initStuff().then((v) {
        runApp(
          MyApp(),
        );

        appNotifications.initPlugin();
      }));
}

bool _isUserNew = true;
Future<void> isUserNew() async {
  var prefs = await SharedPreferences.getInstance();
  _isUserNew = prefs.getBool('isNew') ?? true;
  print(_isUserNew);
}

Future<void> initStuff() async {
  await db.initCategories();
  await db.initQuotes();
}

AppDatabase db = AppDatabase();
AppNotifications appNotifications = AppNotifications();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*   db.insertUser(
        UsersCompanion(firstName: Value('SI'), lastName: Value('dss')));*/
    return MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'),
          Locale('fr'),
        ],
        navigatorKey: GlobalVariable.navState,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Rubik',
          primaryColor: MaterialColor(AppColors.trafficWhite.value, {
            100: AppColors.trafficWhite,
            50: AppColors.trafficWhite,
            200: AppColors.trafficWhite,
            300: AppColors.trafficWhite,
            400: AppColors.trafficWhite,
            500: AppColors.trafficWhite,
            600: AppColors.trafficWhite,
            700: AppColors.trafficWhite,
            800: AppColors.trafficWhite,
            900: AppColors.trafficWhite,
          }),
        ),
        home: SafeArea(
            child: Material(
                child: _isUserNew ? OnBoardScreen() : QuoteFrontPage())));
  }
}
