import 'package:hive/hive.dart';

class TodoDb {
  List todos = [];
  List todosHistory = [];

  final box = Hive.box('MyBox');

  void createInitial() {
    todos = [];
  }

  void loadTodosDB() {
    todos = box.get('TODODB');
  }

  void loadHistortyTodosDB() {
    todosHistory = box.get('ALL_TODODB');
  }

  void updateTodosDB() {
    box.put('TODODB', todos);
  }

  void updateHistoryTodosDB() {
    box.put('ALL_TODODB', todosHistory);
  }
}
