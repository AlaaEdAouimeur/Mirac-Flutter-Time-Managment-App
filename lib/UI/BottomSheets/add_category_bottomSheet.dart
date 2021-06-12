import 'package:flutter/material.dart';
import 'package:tyme/UI/Components/AppTextField.dart';
import 'package:tyme/utils/konstants.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  @override
  _AddCategoryBottomSheetState createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  TextEditingController titleTextEditingController = TextEditingController();
  int selectedColorIndex = -1;
  Widget colorCircle(int index) {
    /*Container(
        margin: EdgeInsets.all(8),
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: colorsList[index],
          shape: BoxShape.circle,
          border: Border.all(
              color: selectedColorIndex == index
                  ? Colors.amber
                  : Colors.transparent),
        ),
      ),*/
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColorIndex = index;
        });
      },
      child: selectedColorIndex == index
          ? Container(
              margin: EdgeInsets.all(8),
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: AppColors.trafficWhite,
                shape: BoxShape.circle,
                border: Border.all(color: colorsList[index]),
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: colorsList[index],
                  shape: BoxShape.circle,
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.all(8),
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: colorsList[index],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.transparent),
              ),
            ),
    );
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Create new category',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Category color',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
