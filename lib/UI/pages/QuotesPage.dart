import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:tyme/UI/BottomSheets/add_quote_bottom_sheet.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/utils/konstants.dart';

class QuotesPage extends StatefulWidget {
  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  Widget _quoteCard(Quote quote) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: 5,
      color: AppColors.trafficWhite,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '“' + quote.content + '”',
              style: TextStyle(fontSize: 22, color: Colors.black87),
            ),
            SizedBox(
              height: 16,
            ),
            quote.author == null
                ? Container()
                : Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      quote.author ?? '',
                      style: TextStyle(
                          color: AppColors.darkGrey,
                          fontStyle: FontStyle.italic),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => AddQuoteBottomSheet()).then((value) {
            setState(() {});
          });
        },
        backgroundColor: AppColors.trafficWhite,
        child: Icon(
          Icons.add,
          color: Colors.black87,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 50,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.modulate,
                      ),
                      child: LottieBuilder.asset(
                        'assets/quotes.json',
                      ),
                    )),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'My Quotes',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              itemCount: quotes.length,
              itemBuilder: (BuildContext context, int index) =>
                  _quoteCard(quotes[index]),
              staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ],
        ),
      ),
    );
  }
}
