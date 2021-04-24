import 'package:flutter_navigator2_sample/core/helper/todo_database_helper.dart';
import 'package:flutter_navigator2_sample/core/state_holder.dart';
import 'package:flutter_navigator2_sample/model/todos_model.dart';
import 'package:flutter_navigator2_sample/navigation/custom_router_delegate.dart';
import 'package:flutter_navigator2_sample/viewmodel/add_update_todo/add_update_todo_bloc.dart';
import 'package:flutter_navigator2_sample/viewmodel/add_update_todo/add_update_todo_state.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_bloc.dart';
import 'package:flutter_navigator2_sample/viewmodel/home/home_state.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => TodoDatabaseHelper());
  sl.registerLazySingleton(() => TodosModel());
  sl.registerLazySingleton(
    () => CustomRouterDelegate(
      todosModel: sl(),
      todoDB: sl(),
    ),
  );
  sl.registerFactory(
    () => HomeBloc(
      todoDB: sl(),
      initialState: HomeState(
        todos: StateHolder.empty(),
      ),
    ),
  );
  sl.registerFactory(
    () => AddUpdateTodoBloc(
      todoDB: sl(),
      initialState: AddUpdateTodoState(
        title: '',
        description: '',
        loading: false,
      ),
    ),
  );
}
