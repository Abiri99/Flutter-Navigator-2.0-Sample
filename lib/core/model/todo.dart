import 'package:flutter/material.dart';

class Todo {
  final int id;
  final String title;
  final String description;

  Todo({
    this.id,
    this.title,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
