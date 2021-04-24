import 'package:equatable/equatable.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/core/state_holder.dart';

class HomeState extends Equatable {

  final StateHolder<List<Todo>> todos;

  HomeState({this.todos});

  HomeState copyWith({StateHolder<List<Todo>> todos}) {
    return HomeState(
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object> get props => [todos];
}