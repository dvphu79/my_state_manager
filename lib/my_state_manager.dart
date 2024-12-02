library my_state_manager;

import 'package:flutter/material.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class MyCounter extends ChangeNotifier {
  int _count = 0; // Sample state variable

  int get count => _count;

  void incrementCount() {
    _count++;
    notifyListeners(); // Tell widgets about the change
  }
}
