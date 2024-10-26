// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTileHistory extends StatelessWidget {
  final String taskName;
  final Function(BuildContext)? deleteTile;

  TodoTileHistory({
    super.key,
    required this.taskName,
    required this.deleteTile,
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
        child: Container(
          padding: EdgeInsets.all(35),
          child: Row(
            children: [
              Text(
                taskName,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Color.fromARGB(171, 93, 64, 55),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
