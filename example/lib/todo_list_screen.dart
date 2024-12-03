import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_state_manager/loading_status.dart';
import 'package:my_state_manager/my_state_manager.dart';
import 'package:my_state_manager/todo.dart';

// ignore: must_be_immutable
class TodoListScreen extends StatefulWidget {
  TodoListScreen({super.key, required this.title});

  // Constructor specifically for tests
  @visibleForTesting
  TodoListScreen.forTest({super.key, required this.title, this.model});

  final String title;

  MyTodoListModel<int>? model;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  var _todoListModel = MyTodoListModel<int>();
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      _todoListModel = widget.model!;
    }
  }

  @override
  void dispose() {
    _todoListModel.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListenableBuilder(
          listenable: _todoListModel, // Listen to changes in _todoListModel
          builder: (context, child) {
            return Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListenableBuilder(
                          listenable:
                              _todoListModel, // Listen to changes in _todoListModel
                          builder: (context, child) {
                            return ListView.builder(
                              itemCount: _todoListModel.todos.length,
                              itemBuilder: (context, index) {
                                final todo = _todoListModel.todos[index];
                                return ListTile(
                                  title: Text(
                                    todo.title,
                                    style: TextStyle(
                                      decoration: todo.completed
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                  leading: Checkbox(
                                    key: Key('checkbox_$index'),
                                    value: todo.completed,
                                    onChanged: (value) {
                                      _todoListModel.toggleTodo(index);
                                    },
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          _showEditDialog(context, index, todo);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          _todoListModel.removeTodo(index);
                                        },
                                      ),
                                    ],
                                  ),
                                  subtitle: todo.data != null
                                      ? Text("ID: ${todo.data}")
                                      : null,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _textController,
                          onFieldSubmitted: (value) {
                            if (_formKey.currentState!.validate()) {
                              _todoListModel.addTodo(value.trim(),
                                  data: aRandomInteger);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a todo';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Add a new todo...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _textController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _todoListModel.loadingStatus == LoadingStatus.inProgress
                    ? overlayView
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget get overlayView => Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );

  // Generate a random integer between 1 (inclusive) and 1000000 (inclusive)
  int get aRandomInteger => Random().nextInt(1000000) + 1;

  void _showEditDialog(BuildContext context, int index, Todo<int> todo) {
    final editController = TextEditingController(text: todo.title);
    final editFormKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Todo"),
          content: Form(
            key: editFormKey,
            child: TextFormField(
              controller: editController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a todo';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (editFormKey.currentState!.validate()) {
                  Navigator.pop(context);
                  await _todoListModel.updateTodo(
                      index, editController.text.trim());
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
