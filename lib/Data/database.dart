import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List ToDoList = [];
  final _myBox = Hive.box("myBox");

  void createInitialData() {
    ToDoList = [
      ["Welcome", true]
    ];
  }

  void loadData() {
    ToDoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", ToDoList);
  }
}
