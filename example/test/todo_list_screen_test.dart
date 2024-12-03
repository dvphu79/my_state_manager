import 'dart:math';
import 'package:example/todo_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_state_manager/loading_status.dart';
import 'package:my_state_manager/my_state_manager.dart';
import 'package:my_state_manager/todo.dart';

void main() {
  late MyTodoListModel<int> myTodoListModel;
  // Generate 10 todo items
  final todos = List.generate(
      10, (index) => Todo<int>(title: 'Todo $index', completed: false));

  setUp(() {
    myTodoListModel = MyTodoListModel<int>(
        todos: todos, loadingStatus: LoadingStatus.initial);
  });

  testWidgets('Verify that the selected todos are marked as completed',
      (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home:
            TodoListScreen.forTest(title: 'Todo List', model: myTodoListModel),
      ),
    );
    await tester.pumpAndSettle();

    // Select 5 random indices to check
    final random = Random();
    final indicesToCheck = <int>{};
    while (indicesToCheck.length < 5) {
      indicesToCheck.add(random.nextInt(5));
    }

    // Check the checkboxes for the selected indices
    for (final index in indicesToCheck) {
      await tester.tap(find.byKey(Key('checkbox_$index')));
      await tester.pumpAndSettle();
    }

    // Verify that the selected todos are marked as completed
    for (final index in indicesToCheck) {
      expect(todos[index].completed, true);
    }
  });
}
