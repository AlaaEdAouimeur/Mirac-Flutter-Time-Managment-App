import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moor/moor.dart';
import 'package:tyme/UI/pages/HomePage.dart';

import 'package:tyme/database/database.dart';
import 'package:tyme/utils/AppLocalizations.dart';
import 'package:tyme/utils/global_vars.dart';

import 'package:tyme/utils/local_notifications.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
  appNotifications.initPlugin();
}

AppDatabase db = new AppDatabase();
AppNotifications appNotifications = new AppNotifications();

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
          Locale("en"),
          Locale("fr"),
        ],
        navigatorKey: GlobalVariable.navState,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: SafeArea(child: Material(child: HomePage())));
  }
}
