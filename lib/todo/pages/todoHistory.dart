import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/todo/components/todoHistory_list.dart';

import '../database/todo_db.dart';

class Todohistory extends StatefulWidget {
  const Todohistory({super.key});

  @override
  State<Todohistory> createState() => _TodohistoryState();
}

class _TodohistoryState extends State<Todohistory> {
  TodoDb database = TodoDb();
  final box = Hive.box('MyBox');
  @override
  void initState() {
    if (box.get('ALL_TODODB') != null) {
      database.loadHistortyTodosDB();
    }
    super.initState();
  }

  void deleteTile(BuildContext? value, index) {
    setState(() {
      database.todosHistory.removeAt(index);
      database.updateHistoryTodosDB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TODOs'),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('lib/todo/Assets/main.jpg'),
            fit: BoxFit.cover,
          )),
          child: ListView.builder(
            itemCount: database.todosHistory.length,
            itemBuilder: (context, index) => TodoTileHistory(
              taskName: database.todosHistory[index]['name'],
              deleteTile: (value) => deleteTile(value, index),
            ),
          ),
        ));
  }
}
