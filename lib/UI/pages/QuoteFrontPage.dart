import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tyme/UI/pages/HomePage.dart';
import 'package:tyme/main.dart';

class QuoteFrontPage extends StatefulWidget {
  @override
  _QuoteFrontPageState createState() => _QuoteFrontPageState();
}

class _QuoteFrontPageState extends State<QuoteFrontPage> {
  final quote = db.getRandomQuote();
  Widget getBookmarkbar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(
          icon: Icon(
            Icons.file_download,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.black,
          ),
          onPressed: () {
            //    Share.share(quotes[index].data['text'] + '\n-' + getAuthor(index));
          },
        )
      ]),
    );
  }

  bool isDone = false;
  Widget _getAuthor() {
    if (!isDone) {
      return SizedBox();
    } else {
      return DefaultTextStyle(
          style: TextStyle(
              color: Color(0xffaaaaaa),
              fontSize: 20.0,
              fontStyle: FontStyle.italic),
          child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [TyperAnimatedText(quote.author ?? '')]));
    }
  }

  @override
  Widget build(BuildContext context) {
    print((quote.content.length * 1.2).round());
    return SizedBox.expand(
      child: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 64,
                ),
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Patrik',
                      color: Colors.black),
                  child: AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation: false,
                      onFinished: () => setState(() => isDone = true),
                      animatedTexts: [
                        TypewriterAnimatedText(quote.content,
                            speed: Duration(milliseconds: 80))
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _getAuthor(),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black54)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Icon(Icons.arrow_forward)),
                )
              ],
            )),
      ),
    );
  }
}
