import 'package:flutter_navigator2_sample/core/model/todo.dart';
import 'package:flutter_navigator2_sample/core/util/custom_change_notifier.dart';

enum TodoAction {
  Update,
  Add,
}

class TodosModel extends CustomChangeNotifier {

  List<Todo> _todos = List.empty();
  List<Todo> get todos => _todos;
  set todos(List<Todo> value) {
    notify(() {_todos = value;});
  }

  int _selectedTodoId;
  int get selectedTodoId => _selectedTodoId;
  set selectedTodoId(int value) {
    notify(() => _selectedTodoId = value);
  }

  TodoAction _selectedTodoAction;
  TodoAction get selectedTodoAction => _selectedTodoAction;
  set selectedTodoAction(TodoAction value) {
    notify(() => _selectedTodoAction = value);
  }

  showUpdateTodoPage(int todoId) {
    notify(() {
      _selectedTodoId = todoId;
      _selectedTodoAction = TodoAction.Update; 
    });
  }

  showAddTodoPage() {
    notify(() {
      _selectedTodoAction = TodoAction.Add; 
    });
  }


  clearSelectedTodoIdAndAction() {
    notify(() {
      _selectedTodoId = null;
      _selectedTodoAction = null;
    });
  }
}