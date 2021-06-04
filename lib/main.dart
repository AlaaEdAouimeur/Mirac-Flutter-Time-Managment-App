import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:moor/moor.dart';
import 'package:tyme/UI/pages/HomePage.dart';
import 'package:tyme/UI/pages/TaskDetails.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/utils/global_vars.dart';
import 'package:tyme/utils/konstants.dart';
import 'package:tyme/utils/local_notifications.dart';

void main() {
  initializeDateFormatting('fr_FR', null).then((_) {
    runApp(ProviderScope(
      child: MyApp(),
    ));
    appNotifications.initPlugin();
  });
}

AppDatabase db = new AppDatabase();
AppNotifications appNotifications = new AppNotifications();

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
        navigatorKey: GlobalVariable.navState,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: SafeArea(child: Material(child: HomePage())));
  }
}
