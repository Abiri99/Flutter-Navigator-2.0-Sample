import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/screen/add_update_todo_screen.dart';
import 'package:flutter_navigator2_sample/viewmodel/add_update_todo/add_update_todo_bloc.dart';

class AddUpdateTodoPage extends Page {
  final Todo todo;
  final Future Function(Todo todo) onAddTodoCallback;
  final Future Function(Todo todo) onUpdateTodoCallback;

  AddUpdateTodoPage({
    this.todo,
    this.onAddTodoCallback,
    this.onUpdateTodoCallback,
  });

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, firstAnim, secondAnim) {
        var animation = Tween(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(parent: firstAnim, curve: Curves.ease));
        var secondaryAnimation = Tween(begin: 0.0, end: 0.2)
            .animate(CurvedAnimation(parent: secondAnim, curve: Curves.ease));
        return AnimatedBuilder(
          animation: animation,
          builder: (context, widget) {
            return AnimatedBuilder(
              animation: secondaryAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                      (1 - animation.value + secondaryAnimation.value) *
                          MediaQuery.of(context).size.width,
                      0.0),
                  child: BlocProvider<AddUpdateTodoBloc>(
                    create: (context) => sl<AddUpdateTodoBloc>(),
                    child: AddUpdateTodoScreen(
                      todo: todo,
                      onAddTodoCallback: onAddTodoCallback,
                      onUpdateTodoCallback: onUpdateTodoCallback,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      transitionDuration: Duration(milliseconds: 400),
      reverseTransitionDuration: Duration(milliseconds: 400),
    );
  }
}
