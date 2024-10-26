// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/todo/components/pop_up_add_input.dart';
import 'package:test_app/todo/components/pop_up_edit_input.dart';
import 'package:test_app/todo/components/todo_list.dart';
import 'package:test_app/todo/database/todo_db.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final newTaskInput = TextEditingController();
  TodoDb database = TodoDb();
  final box = Hive.box('MyBox');

  @override
  void initState() {
    if (box.get('TODODB') == null) {
      database.createInitial();
    } else {
      database.loadTodosDB();
    }
    super.initState();
  }

  void onChangeBool(bool? value, int index) {
    setState(() {
      database.todos[index]['status'] = !database.todos[index]['status'];
      database.todos.sort(
        (a, b) => (a['status'] == b['status']
            ? 0
            : a['status']
                ? 1
                : -1),
      );
    });
  }

  void saveBtn() {
    setState(() {
      database.todos.add({'name': newTaskInput.text, 'status': false});
      database.todosHistory.add({'name': newTaskInput.text});
      newTaskInput.text = '';
      database.updateTodosDB();
      database.updateHistoryTodosDB();
    });
    Navigator.of(context).pop();
  }

  void cancelBtn() {
    Navigator.of(context).pop();
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) => PopUpAddInput(
        cancelBtn: cancelBtn,
        newTaskInput: newTaskInput,
        saveBtn: saveBtn,
      ),
    );
  }

  void deleteTile(BuildContext? value, index) {
    setState(() {
      database.todos.removeAt(index);
      database.updateTodosDB();
    });
  }

  void editBtn(int index) {
    setState(() {
      database.todos[index] = {'name': newTaskInput.text, 'status': false};
      database.todosHistory.add({'name': newTaskInput.text});
      newTaskInput.text = '';
      database.updateTodosDB();
      database.updateHistoryTodosDB();
    });
    Navigator.of(context).pop();
  }

  void editTile(BuildContext? value, index) {
    showDialog(
      context: context,
      builder: (context) => PopUpEditInput(
        newTaskInput: newTaskInput,
        editBtn: () => editBtn(index),
        cancelBtn: cancelBtn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODOs'),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        backgroundColor: const Color.fromARGB(173, 93, 64, 55),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('lib/todo/Assets/main.jpg'),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'What To Do List!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RomanticFont'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: ListView.builder(
                itemCount: database.todos.length,
                itemBuilder: (context, index) => TodoTile(
                  taskName: database.todos[index]['name'],
                  doneTask: database.todos[index]['status'],
                  onChangeBool: (value) => onChangeBool(value, index),
                  deleteTile: (value) => deleteTile(value, index),
                  editTile: (value) => editTile(value, index),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(202, 121, 85, 72),
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.list,
                size: 48,
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              iconColor: Colors.white,
              title: Text('Home'),
              titleTextStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              onTap: () {
                Navigator.popAndPushNamed(context, '/mainTodo');
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              iconColor: Colors.white,
              title: Text('History'),
              titleTextStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              onTap: () {
                Navigator.popAndPushNamed(context, '/historyTodo');
              },
            ),
          ],
        ),
      ),
    );
  }
}
