import 'package:flutter/material.dart';
import 'package:flutter_navigator2_sample/core/helper/todo_database_helper.dart';
import 'package:flutter_navigator2_sample/custom_app.dart';
import 'package:flutter_navigator2_sample/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await sl<TodoDatabaseHelper>().setup();
  runApp(CustomApp());
}