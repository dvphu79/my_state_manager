import 'package:flutter/material.dart';
import 'package:my_state_manager/my_state_manager.dart';

class MyCounterScreen extends StatefulWidget {
  const MyCounterScreen({super.key, required this.title});

  final String title;

  @override
  State<MyCounterScreen> createState() => _MyCounterScreenState();
}

class _MyCounterScreenState extends State<MyCounterScreen> {
  final MyCounter _myCounter = MyCounter();

  void _onTapIncrementButton() {
    _myCounter.incrementCount();
  }

  void _onTapResetButton() {
    _myCounter.resetCount();
  }

  @override
  void dispose() {
    _myCounter.dispose();
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _onTapIncrementButton,
                child: const Text('Increment'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onTapResetButton,
                child: const Text('Reset'),
              ),
              const SizedBox(height: 16),
              const Text(
                'You have pushed the button this many times:',
              ),
              ListenableBuilder(
                listenable: _myCounter,
                builder: (context, child) => Text(
                  '${_myCounter.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
