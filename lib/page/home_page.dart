import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/screen/home_screen.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_bloc.dart';

class HomePage extends Page {
  final List<Todo> todos;
  final Function(int todoId) onTodoItemTap;
  final Function(int todoId) onTodoItemUpdateButtonTap;
  final Function() onFabPressed;

  HomePage({
    @required this.todos,
    @required this.onTodoItemTap,
    @required this.onTodoItemUpdateButtonTap,
    @required this.onFabPressed,
  })  : assert(onTodoItemTap != null),
        assert(onTodoItemUpdateButtonTap != null),
        assert(onFabPressed != null),
        super(key: ValueKey('HomePage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, firstAnim, secondAnim) {
        var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: firstAnim, curve: Curves.ease));
        var secondaryAnimation = Tween(begin: 0.0, end: 0.3).animate(CurvedAnimation(parent: secondAnim, curve: Curves.ease));
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) => AnimatedBuilder(
            animation: secondaryAnimation,
            builder: (context, child) {
              print('animation: ${animation.value}');
              print('secondaryAnimation: ${secondaryAnimation.value}');
              return Transform.scale(
              scale: (animation.value - secondaryAnimation.value),
              child: BlocProvider<HomeBloc>(
                create: (_) => sl<HomeBloc>(),
                child: HomeScreen(
                  todos: todos,
                  onTodoItemTap: onTodoItemTap,
                  onTodoItemUpdateButtonTap: onTodoItemUpdateButtonTap,
                  onFabPressed: onFabPressed,
                ),
              ),
            );
            },
          ),
        );
      },
      transitionDuration: Duration(seconds: 1),
      reverseTransitionDuration: Duration(seconds: 1),
      // builder: (BuildContext context) => BlocProvider<HomeBloc>(
      //   create: (_) => sl<HomeBloc>(),
      //   child: HomeScreen(
      //     todos: todos,
      //     onTodoItemTap: onTodoItemTap,
      //     onTodoItemUpdateButtonTap: onTodoItemUpdateButtonTap,
      //     onFabPressed: onFabPressed,
      //   ),
      // ),
    );
  }
}
