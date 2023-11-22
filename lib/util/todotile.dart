// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskname;
  final bool taskCompleted;
  final Function(bool?)? onChanged;

  TodoTile({
    Key? key,
    required this.taskname,
    required this.onChanged,
    required this.taskCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.yellow,
        ),
        child: Row(
          children: [
            Checkbox(value: taskCompleted, onChanged: onChanged),
            Text(taskname, style: TextStyle(fontFamily: "Poppins"))
          ],
        ),
      ),
    );
  }
}
