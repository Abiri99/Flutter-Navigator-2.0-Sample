import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';

class TodoDetailScreen extends StatelessWidget {
  final Function() fetchPrerequisitesCallback;
  final Todo todo;

  TodoDetailScreen({
    @required this.fetchPrerequisitesCallback,
    @required this.todo,
  }) : assert(todo != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            todo.title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
