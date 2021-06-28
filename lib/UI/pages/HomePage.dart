import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:tyme/UI/Components/calendar.dart';
import 'package:tyme/UI/pages/QuotesPage.dart';
import 'package:tyme/UI/pages/TasksHomePage.dart';
import 'package:tyme/UI/pages/UserHome.dart';
import 'package:tyme/utils/konstants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  int _bottomNavIndex = 2;
  CalendarFormat cf = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: GNav(
          tabMargin: EdgeInsets.all(2),
          // rippleColor: Colors.grey[300],
          //  hoverColor: Colors.grey[100],
          gap: 8,
          activeColor: Colors.blue,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: AppColors.trafficWhite,
          color: Colors.black,
          backgroundColor: Colors.white,
          selectedIndex: _bottomNavIndex,
          onTabChange: (index) => setState(() => _bottomNavIndex = index),
          //onTap: (i) => setState(() => _bottomNavIndex = i),
          tabs: [
            /// Home
            GButton(
              icon: Icons.list_alt_rounded,
              text: 'Tasks',
            ),

            /// Likes
            GButton(
              icon: Icons.question_answer_rounded,
              text: 'Quote',
            ),
            GButton(
              icon: Icons.calendar_today_rounded,
              text: 'Tasks',
            ),

            GButton(
              icon: Icons.person,
              text: 'Me',
            ),
          ],
        ),
        body: IndexedStack(
          index: _bottomNavIndex,
          children: [
            TasksHomePage(),
            QuotesPage(),
            CalendarWidget(),
            UserHome()
          ],
        ),
      ),
    );
  }
}
