// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/Data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ToDoDataBase db = ToDoDataBase();
  final _myBox = Hive.box("myBox");

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  TextEditingController myController = TextEditingController();

  void CheckBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateData();
  }

  void addNewTask() {
    setState(() {
      db.ToDoList.add([myController.text, false]);
      myController.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createTodo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.yellow[100],
            content: Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Add new task"),
                    controller: myController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          addNewTask();
                        },
                        color: Colors.yellow,
                        child: Text(
                          "Save",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.red,
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text(
          "T O   D O",
          style: TextStyle(fontFamily: "Poppins"),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createTodo();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) => Padding(
          padding:
              const EdgeInsets.only(top: 10.0, left: 15, right: 15, bottom: 5),
          child: Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    deleteTask(index);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.yellow,
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: db.ToDoList[index][1],
                    onChanged: (value) => CheckBoxChanged(value, index),
                    activeColor: Colors.black,
                  ),
                  Text(db.ToDoList[index][0],
                      style: TextStyle(
                          fontFamily: "Poppins",
                          decoration: db.ToDoList[index][1]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
