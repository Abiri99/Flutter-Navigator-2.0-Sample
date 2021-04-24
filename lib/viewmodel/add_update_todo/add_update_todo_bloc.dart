import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigator2_sample/core/helper/todo_database_helper.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';
import 'package:flutter_navigator2_sample/navigation/custom_router_delegate.dart';
import 'package:flutter_navigator2_sample/viewmodel/add_update_todo/add_update_todo_event.dart';
import 'package:flutter_navigator2_sample/viewmodel/add_update_todo/add_update_todo_state.dart';

class AddUpdateTodoBloc extends Bloc<AddUpdateTodoEvent, AddUpdateTodoState> {
  final TodoDatabaseHelper todoDB;

  AddUpdateTodoBloc({
    @required this.todoDB,
    AddUpdateTodoState initialState,
  })  : assert(todoDB != null),
        super(initialState);

  @override
  Stream<AddUpdateTodoState> mapEventToState(AddUpdateTodoEvent event) async* {
    switch (event.runtimeType) {
      case AddUpdateTodoTitleSet:
        yield* _mapTitleSetToState((event as AddUpdateTodoTitleSet).title);
        break;
      case AddUpdateTodoDescriptionSet:
        yield* _mapDescriptionSetToState(
            (event as AddUpdateTodoDescriptionSet).description);
        break;
      case AddUpdateTodoAddItemToDB:
        yield* _mapAddItemToDBToState();
        break;
      case AddUpdateTodoUpdateDBItem:
        yield* _mapUpdateDBItemToState(
            (event as AddUpdateTodoUpdateDBItem).todoId);
        break;
      default:
        break;
    }
  }

  Stream<AddUpdateTodoState> _mapTitleSetToState(String title) async* {
    yield state.copyWith(
      title: title,
    );
  }

  Stream<AddUpdateTodoState> _mapDescriptionSetToState(
      String description) async* {
    yield state.copyWith(description: description);
  }

  Stream<AddUpdateTodoState> _mapAddItemToDBToState() async* {
    yield state.copyWith(
      overlayLoadingIndicatorIsVisible: true,
    );
    await todoDB.insertTodo(
      Todo(
        title: state.title,
        description: state.description,
      ),
    );
    yield state.copyWith(
      overlayLoadingIndicatorIsVisible: false,
    );
    sl<CustomRouterDelegate>().navigatorKey.currentState.pop();
  }

  Stream<AddUpdateTodoState> _mapUpdateDBItemToState(int todoId) async* {
    yield state.copyWith(
      overlayLoadingIndicatorIsVisible: true,
    );
    await todoDB.updateTodo(
      Todo(
        id: todoId,
        title: state.title,
        description: state.description,
      ),
    );
    yield state.copyWith(
      overlayLoadingIndicatorIsVisible: false,
    );
    sl<CustomRouterDelegate>().navigatorKey.currentState.pop();
  }
}
