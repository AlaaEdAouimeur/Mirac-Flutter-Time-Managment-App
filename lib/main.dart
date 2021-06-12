import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyme/UI/pages/HomePage.dart';

import 'package:tyme/database/database.dart';
import 'package:tyme/utils/AppLocalizations.dart';
import 'package:tyme/utils/global_vars.dart';
import 'package:tyme/utils/konstants.dart';

import 'package:tyme/utils/local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getCategories().then((v) {
    runApp(ProviderScope(
      child: MyApp(),
    ));

    appNotifications.initPlugin();
  });
}

Future<void> getCategories() async {
  await db.initCategories();
}

AppDatabase db = AppDatabase();
AppNotifications appNotifications = AppNotifications();

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context).textTheme,
          ),
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
        home: SafeArea(child: Material(child: HomePage())));
  }
}
