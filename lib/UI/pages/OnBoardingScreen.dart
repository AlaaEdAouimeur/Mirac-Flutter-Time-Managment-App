import 'package:concentric_transition/page_route.dart';
import 'package:concentric_transition/page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moor/moor.dart' as moor;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tyme/UI/Components/AppTextField.dart';
import 'package:tyme/UI/pages/HomePage.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  Widget _userWidget() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: LottieBuilder.asset(
                'assets/onboarding/wizard.json',
              ),
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    text: 'My name is',
                    children: [
                  TextSpan(
                    text: ' Mirac ',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[600]),
                  ),
                  TextSpan(
                    text: 'the wizard',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ])),
            SizedBox(height: 16),
            AppTextField(
              hintText: 'What is yours ?',
              textEditingController: textEditingController,
              isObligatory: true,
              color: Color(0xfff3c637),
            ),

            /*   OutlinedButton(onPressed: (){}, child: Text('Go !'),style:  ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith(
                                        (states) => )),),*/
            Padding(padding: EdgeInsets.only(bottom: 225))
          ],
        ),
      ),
    );
  }

  Widget _pageWidget(String lottie, String text, bool repeat) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LottieBuilder.asset(
              'assets/onboarding/$lottie.json',
              repeat: repeat,
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Padding(padding: EdgeInsets.only(bottom: 250))
          ],
        ),
      ),
    );
  }

  List<Widget> pages = [];
  @override
  void initState() {
    super.initState();
    pages = [
      _pageWidget('workload', 'Unorganised ?', true),
      _pageWidget('calendar-success', 'Want to be on time ?', true),
      _pageWidget('checklist', 'To finish all your tasks ?', false),
      _pageWidget('workspace', 'To be productive ?', false),
      _pageWidget('last', 'Get started with MIRAC !', true),
      _userWidget(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        onChange: (i) {
          print(i);
        },
        onFinish: () async {
          if (_formKey.currentState!.validate()) {
            var prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isNew', false);
            await db
                .insertUser(UsersCompanion(
                    firstName: moor.Value(textEditingController.text),
                    lastName: moor.Value(textEditingController.text)))
                .then((value) =>
                    Navigator.push(context, CupertinoPageRoute(builder: (ctx) {
                      return HomePage();
                    })));
          }
        },
        colors: <Color>[
          Color(0xff94D0CC),
          Color(0xffEEC4C4),
          Color(0xffF29191),
          Colors.blueGrey.shade500,
          Color(0xff94D0CC),
          Color(0xff1768AC),
          /* colorsList[2],
          colorsList[4],
          colorsList[6],
          colorsList[1],*/
        ],
        itemCount: pages.length, // null = infinity
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (int index, double value) {
          return pages[index];
        },
      ),
    );
  }
}
