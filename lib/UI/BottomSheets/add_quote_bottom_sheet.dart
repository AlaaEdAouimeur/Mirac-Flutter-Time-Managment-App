import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as moor;
import 'package:tyme/UI/Components/AppTextField.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/konstants.dart';

class AddQuoteBottomSheet extends StatefulWidget {
  @override
  AddQuoteBottomSheetState createState() => AddQuoteBottomSheetState();
}

class AddQuoteBottomSheetState extends State<AddQuoteBottomSheet> {
  TextEditingController quoteTextEditingController = TextEditingController();
  TextEditingController authorTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.trafficWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add new quote',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                AppTextField(
                  maxLines: 3,
                  hintText: 'Quote ..... ',
                  textEditingController: quoteTextEditingController,
                  isObligatory: true,
                  //  color: Color(categories[_selectedCategoryIndex].color),
                  color: AppColors.trafficWhite,
                ),
                SizedBox(
                  height: 8,
                ),
                AppTextField(
                  maxLines: 1,
                  hintText: 'By ..... ',
                  textEditingController: authorTextEditingController,
                  isObligatory: true,
                  //  color: Color(categories[_selectedCategoryIndex].color),
                  color: AppColors.trafficWhite,
                ),
                SizedBox(
                  height: 8,
                ),
                ClipOval(
                  child: Material(
                    color: Colors.transparent, // Button color
                    child: InkWell(
                      splashColor: Colors.blue.shade200,
                      onTap: _handleDoneButton,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDoneButton() {
    db
        .insertQuote(
          QuotesCompanion(
              content: moor.Value(quoteTextEditingController.text),
              author: authorTextEditingController.text.isNotEmpty
                  ? moor.Value(authorTextEditingController.text)
                  : moor.Value(null)),
        )
        .then((value) => Navigator.pop(context));
  }
}
