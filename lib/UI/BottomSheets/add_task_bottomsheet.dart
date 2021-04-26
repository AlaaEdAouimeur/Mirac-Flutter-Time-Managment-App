import 'package:flutter/material.dart';
import 'package:tyme/UI/Components/AppTextField.dart';
import 'package:tyme/models/Task.dart';

class AddTaskBottomSheet extends StatelessWidget {
  final DateTime? selectedDay;

  const AddTaskBottomSheet({Key? key, this.selectedDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 30),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            AppTextField(
              hintText: 'What Task',
            ),
            AppTextField(
              hintText: 'Description',
            ),
            AppTextField(
              hintText: 'WWHY',
            ),
            AppTextField(
              hintText: 'WWHY',
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop(Task(
                      color: Colors.yellow,
                      dateStart: selectedDay ?? DateTime.now(),
                      dateEnd: selectedDay ?? DateTime.now(),
                      iconData: Icons.history_edu,
                      isAllDay: false,
                      note: 'dsd',
                      title: 'dsd'));
                },
                icon: Icon(Icons.done),
                label: Text('Done'))
          ],
        ),
      )),
    );
  }
}
