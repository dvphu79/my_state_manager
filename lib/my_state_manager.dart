library my_state_manager;

import 'package:flutter/material.dart';
import 'package:my_state_manager/loading_status.dart';
import 'package:my_state_manager/todo.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

/// A Counter model.
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

/// Create a MyTodoListModel to manage the list of todos and notify listeners
class MyTodoListModel<T> extends ChangeNotifier {
  MyTodoListModel(
      {List<Todo<T>> todos = const [],
      LoadingStatus loadingStatus = LoadingStatus.initial}) {
    _todos = List.from(todos, growable: true);
    _loadingStatus = loadingStatus;
  }

  late List<Todo<T>> _todos;

  List<Todo<T>> get todos => _todos;

  late LoadingStatus _loadingStatus;

  LoadingStatus get loadingStatus => _loadingStatus;

  void addTodo(String title, {T? data}) {
    _todos.add(Todo(title: title, data: data));
    notifyListeners(); // Tell widgets about the change
  }

  void toggleTodo(int index) {
    _todos[index].completed = !_todos[index].completed;
    notifyListeners(); // Tell widgets about the change
  }

  Future<void> updateTodo(int index, String title) async {
    updateLoadingStatus(LoadingStatus.inProgress);
    _todos[index].title = title;
    await Future.delayed(const Duration(seconds: 1));
    updateLoadingStatus(LoadingStatus.completed);
    notifyListeners(); // Tell widgets about the change
  }

  void removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners(); // Tell widgets about the change
  }

  void updateLoadingStatus(LoadingStatus loadingStatus) {
    _loadingStatus = loadingStatus;
    notifyListeners(); // Tell widgets about the change
  }
}
