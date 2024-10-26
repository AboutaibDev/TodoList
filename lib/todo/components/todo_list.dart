// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool doneTask;
  final Function(bool?)? onChangeBool;
  final Function(BuildContext)? deleteTile;
  final Function(BuildContext)? editTile;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.doneTask,
    required this.onChangeBool,
    required this.deleteTile,
    required this.editTile,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteTile,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        startActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: editTile,
            icon: Icons.edit,
            backgroundColor: Colors.green,
            borderRadius: BorderRadius.circular(12),
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(35),
          child: Row(
            children: [
              Checkbox(
                value: doneTask,
                onChanged: onChangeBool,
                checkColor: Colors.black,
                activeColor: Colors.white,
              ),
              Text(
                taskName,
                style: TextStyle(
                    decoration: doneTask ? TextDecoration.lineThrough : null,
                    color: Colors.white,
                    fontSize: 18),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: const Color.fromARGB(171, 93, 64, 55),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
