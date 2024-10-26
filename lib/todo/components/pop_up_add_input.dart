// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:test_app/todo/components/buttons.dart';

class PopUpAddInput extends StatelessWidget {
  final newTaskInput;
  VoidCallback saveBtn;
  VoidCallback cancelBtn;

  PopUpAddInput({
    super.key,
    required this.newTaskInput,
    required this.saveBtn,
    required this.cancelBtn,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(202, 121, 85, 72),
      content: Container(
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            TextField(
                controller: newTaskInput,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'New Task..',
                    hintStyle: TextStyle(color: Colors.white))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save Button
                MyButton(text: 'Save', onPress: saveBtn),
                // cancel Button
                MyButton(text: 'Cancel', onPress: cancelBtn)
              ],
            )
          ],
        ),
      ),
    );
  }
}
