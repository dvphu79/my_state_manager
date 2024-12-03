import 'package:example/my_counter_screen.dart';
import 'package:example/todo_list_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TodoListScreen(title: 'Todo List'),
                        ),
                      );
                    },
                    child: const Text('Todo List'),
                  ),
                );
              case 1:
                return ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyCounterScreen(title: 'My Counter Screen'),
                        ),
                      );
                    },
                    child: const Text('My Counter Screen'),
                  ),
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
