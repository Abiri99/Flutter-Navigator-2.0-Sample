import 'package:flutter/material.dart';

class CustomChangeNotifier extends ChangeNotifier {

  void notify([VoidCallback action]) {
    action?.call();
    notifyListeners();
  }
}