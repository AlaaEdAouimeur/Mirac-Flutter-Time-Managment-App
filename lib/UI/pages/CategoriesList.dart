import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:tyme/UI/BottomSheets/add_category_bottomSheet.dart';
import 'package:tyme/database/database.dart';
import 'package:tyme/main.dart';
import 'package:tyme/utils/konstants.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final CustomPopupMenuController _controller = CustomPopupMenuController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AddCategoryBottomSheet());
        },
        backgroundColor: AppColors.trafficWhite,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Categories Managment'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  leading: Icon(Icons.lens_rounded,
                      color: Color(categories[index].color)),
                  title: Text(categories[index].content),
                  trailing: Padding(
                    padding: EdgeInsets.all(20),
                    child: CustomPopupMenu(
                      menuBuilder: () => ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          color: AppColors.trafficWhite,
                          child: IntrinsicWidth(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () {
                                    db
                                        .deleteCategory(categories[index])
                                        .then((value) => setState(() {}));
                                    _controller.hideMenu();
                                    print('pressed');
                                  },
                                  child: Container(
                                    height: 40,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.delete,
                                          size: 15,
                                          color: Colors.black,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      pressType: PressType.singleClick,
                      verticalMargin: -10,
                      controller: _controller,
                      child: Icon(Icons.more_vert),
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
