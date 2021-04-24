import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/helper/todo_database_helper.dart';
import 'package:flutter_navigator2_sample/core/state_holder.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_event.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TodoDatabaseHelper todoDB;

  HomeBloc({@required this.todoDB, HomeState initialState})
      : assert(todoDB != null),
        super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeTodosFetched) {
      yield* _mapTodosFetchedToState();
    }
  }

  Stream<HomeState> _mapTodosFetchedToState() async* {
    yield state.copyWith(
      todos: StateHolder.loading(),
    );
    var response = await todoDB.todos();
    yield state.copyWith(
      todos: StateHolder.completed(response),
    );
  }
}
