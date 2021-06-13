import 'package:flutter/material.dart';
import 'package:moor/moor.dart' as moor;
import 'package:tyme/UI/Components/AppTextField.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/konstants.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  @override
  _AddCategoryBottomSheetState createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  TextEditingController titleTextEditingController = TextEditingController();
  int selectedColorIndex = 0;
  int selectedIconIndex = 0;
  void _handleDoneButton() {
    if (_formKey.currentState!.validate()) {
      db
          .insertCategories(CategoriesCompanion(
              color: moor.Value(colorsList[selectedColorIndex].value),
              iconData: moor.Value(icons[selectedIconIndex].codePoint),
              content: moor.Value(titleTextEditingController.text)))
          .then((value) => Navigator.of(context).pop());
    } else {
      print('form not validated');
    }
  }

  Widget colorCircle(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColorIndex = index;
        });
      },
      child: selectedColorIndex == index
          ? Container(
              margin: EdgeInsets.all(8),
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: AppColors.trafficWhite,
                shape: BoxShape.circle,
                border: Border.all(color: colorsList[index]),
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: colorsList[index],
                  shape: BoxShape.circle,
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.all(8),
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: colorsList[index],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.transparent),
              ),
            ),
    );
  }

  Widget _iconWidget(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIconIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == selectedIconIndex
              ? Colors.blue.shade900
              : AppColors.trafficWhite,
          border: Border.all(color: Colors.blue.shade900),
        ),
        child: Icon(
          icons[index],
          size: 20,
          color: index == selectedIconIndex
              ? AppColors.trafficWhite
              : Colors.blue.shade900,
        ),
      ),
    );
  }

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
          padding: EdgeInsets.all(8),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Create new category',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  AppTextField(
                    hintText: 'What Task',
                    textEditingController: titleTextEditingController,
                    isObligatory: true,
                    //  color: Color(categories[_selectedCategoryIndex].color),
                    color: AppColors.trafficWhite,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Category customization',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
                      // height: 150,
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: icons.length,
                        itemBuilder: (BuildContext context, int index) =>
                            _iconWidget(index),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
                      // height: 150,
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: colorsList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            colorCircle(index),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // The InkWell wraps the custom flat button widget.
                        ClipOval(
                          child: Material(
                            color: Colors.transparent, // Button color
                            child: InkWell(
                              splashColor: selectedColorIndex == -1
                                  ? Colors.blue.shade200
                                  : colorsList[selectedColorIndex],
                              onTap: _handleDoneButton,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: selectedColorIndex == -1
                                          ? Colors.blue.shade200
                                          : colorsList[selectedColorIndex]),
                                ),
                              ),
                            ),
                          ),
                        ),

                        /*Center(
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: selectedColorIndex == -1
                                          ? Colors.blue.shade200
                                          : colorsList[selectedColorIndex]),
                                ),
                              ),*/
                        /*  ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith(
                                    (states) => selectedColorIndex == -1
                                        ? Colors.blue.shade200
                                        : colorsList[selectedColorIndex])),
                            onPressed: _handleDoneButton,
                            icon: Icon(Icons.done),
                            label: Text('Done'))*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
