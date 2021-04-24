import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/core/model/todo.dart';

abstract class AddUpdateTodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUpdateTodoTitleSet extends AddUpdateTodoEvent {
  final String title;

  AddUpdateTodoTitleSet({@required this.title}): assert(title != null);

  @override
  List<Object> get props => [title];
}

class AddUpdateTodoDescriptionSet extends AddUpdateTodoEvent {
  final String description;

  AddUpdateTodoDescriptionSet({@required this.description}): assert(description != null);

  @override
  List<Object> get props => [description];
}

class AddUpdateTodoAddItemToDB extends AddUpdateTodoEvent {}

class AddUpdateTodoUpdateDBItem extends AddUpdateTodoEvent {
  final int todoId;

  AddUpdateTodoUpdateDBItem({@required this.todoId}): assert(todoId != null);

  @override
  List<Object> get props => [todoId];
}