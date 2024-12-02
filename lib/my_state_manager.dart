library my_state_manager;

import 'package:flutter/material.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class MyCounter extends ChangeNotifier {
  MyCounter({int count = 0}) {
    _count = count;
  }

  late int _count;
  int get count => _count;

  void incrementCount() {
    _count++;
    notifyListeners(); // Tell widgets about the change
  }

  void resetCount() {
    _count = 0;
    notifyListeners(); // Tell widgets about the change
  }
}
