import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/core/helper/todo_database_helper.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/model/todos_model.dart';
import 'package:flutter_navigator2_sample/navigation/custom_route_configuration.dart';
import 'package:flutter_navigator2_sample/page/add_update_todo_page.dart';
import 'package:flutter_navigator2_sample/page/home_page.dart';
import 'package:flutter_navigator2_sample/page/todo_detail_page.dart';

class CustomRouterDelegate extends RouterDelegate<CustomRouteConfiguration>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<CustomRouteConfiguration> {
  final TodosModel todosModel;

  final TodoDatabaseHelper todoDB;

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  CustomRouterDelegate({
    @required this.todosModel,
    @required this.todoDB,
  })  : assert(todosModel != null),
        assert(todoDB != null),
        _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
    _setupListeners();
  }

  Future<void> _init() async {
    todosModel.todos = await todoDB.todos();
  }

  _setupListeners() {
    todosModel.addListener(notifyListeners);
  }

  @override
  void dispose() {
    todosModel.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool _showUpdateTodoPage = todosModel.selectedTodoId != null &&
        todosModel.selectedTodoAction == TodoAction.Update;
    final bool _showAddTodoPage =
        todosModel.selectedTodoAction == TodoAction.Add;
    final bool _showTodoDetailPage = todosModel.selectedTodoId != null &&
        todosModel.selectedTodoAction == null;
    return Navigator(
      key: _navigatorKey,
      pages: [
        HomePage(
            todos: todosModel.todos,
            onTodoItemTap: (int todoId) {
              todoId = todoId;
            },
            onTodoItemUpdateButtonTap: (int todoId) {
              todosModel.showUpdateTodoPage(todoId);
            },
            onFabPressed: () {
              todosModel.showAddTodoPage();
            }),
        if (_showTodoDetailPage) ...[
          TodoDetailPage(
            todo: todosModel.todos.firstWhere((todo) {
              if (todo.id == todosModel.selectedTodoId) {
                return true;
              }
              return false;
            }),
            fetchPrerequisitesCallback: () async {
              if (todosModel.todos == null) {
                todosModel.todos = await todoDB.todos();
              }
            },
          ),
        ] else if (_showUpdateTodoPage) ...[
          AddUpdateTodoPage(
            todo: todosModel.todos.firstWhere(
                (element) => element.id == todosModel.selectedTodoId),
          ),
        ] else if (_showAddTodoPage) ...[
          AddUpdateTodoPage(
            onAddTodoCallback: (Todo todo) async {
              todosModel.todos = null;
              todosModel.todos = await todoDB.todos();
              return;
            },
          )
        ],
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (_showTodoDetailPage) {
          todosModel.selectedTodoId = null;
        } else if (_showAddTodoPage) {
          todosModel.selectedTodoAction = null;
        } else if (_showUpdateTodoPage) {
          todosModel.clearSelectedTodoIdAndAction();
        }
        return true;
      },
    );
  }

  @override
  CustomRouteConfiguration get currentConfiguration {
    return CustomRouteConfiguration(todoId: todosModel.selectedTodoId);
  }

  @override
  Future<void> setNewRoutePath(CustomRouteConfiguration configuration) async {
    if (todosModel.selectedTodoId == null) {
      todosModel.todos = await todoDB.todos();
    }

    if (configuration.todoId != null) {
      Future.delayed(
        Duration(milliseconds: 100),
        () {
          todosModel.selectedTodoId = configuration.todoId;
        },
      );
    }

    return null;
  }
}
