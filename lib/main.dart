// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_app/todo/pages/todoHistory.dart';
import 'package:test_app/todo/pages/todoMain.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('MyBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Todo(),
      initialRoute: '/mainTodo',
      routes: {
        '/mainTodo': (context) => Todo(),
        '/historyTodo': (context) => Todohistory(),
      },
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.brown[800],
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ))),
    );
  }
}
