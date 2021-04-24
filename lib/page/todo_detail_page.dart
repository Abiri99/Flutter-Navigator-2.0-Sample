import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/screen/todo_detail_screen.dart';

class TodoDetailPage extends Page {
  final Function() fetchPrerequisitesCallback;
  final Todo todo;

  TodoDetailPage({
    @required this.fetchPrerequisitesCallback,
    @required this.todo,
  }) : super(key: ValueKey('TodoDetailPage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Transform.translate(
          offset: Offset(
            1.0 - animation.value,
            0.0,
          ),
          child: TodoDetailScreen(
            todo: todo,
            fetchPrerequisitesCallback: fetchPrerequisitesCallback,
          ),
        );
      },
      transitionDuration: Duration(seconds: 5),
      reverseTransitionDuration: Duration(seconds: 5),
      // builder: (BuildContext context) => TodoDetailScreen(
      //   todo: todo,
      //   fetchPrerequisitesCallback: fetchPrerequisitesCallback,
      // ),
    );
  }
}
