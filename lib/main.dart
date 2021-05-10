import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tyme/UI/HomePage.dart';
import 'package:tyme/UI/TaskDetails.dart';

void main() {
  initializeDateFormatting('fr_FR', null).then((_) => runApp(ProviderScope(
        child: MyApp(),
      )));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: SafeArea(child: Material(child: HomePage())));
  }
}
