import 'dart:async';

import 'package:flutter/material.dart';

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  _StreamHomePageState createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomePage> {
  final StreamController<int> _counterController = StreamController();
  int _counter = 0; // Initialize the counter

  @override
  void initState() {
    super.initState();
    _loadInitialCounterValue();
  }

  Future<void> _loadInitialCounterValue() async {
    final initialValue = await fetchInitialCounterValue();
    _counter = initialValue;
    _counterController.add(_counter);
  }

  @override
  void dispose() {
    _counterController.close();
    super.dispose();
  }

  // Simulated asynchronous operation to fetch initial counter value
  Future<int> fetchInitialCounterValue() async {
    // Simulate a network call or some asynchronous task
    await Future.delayed(const Duration(seconds: 2));
    return 10; // Return a sample initial counter value
  }

  void _incrementCounter() {
    _counter++;
    _counterController.add(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Streams"),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _counterController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the Future is still loading, show a loading indicator
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If there is an error, display the error message
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // If the Future completed successfully, set the initial counter value
              if (_counter == 0) {
                _counter = snapshot.data!;
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              );
            } else {
              // Handle the case where there is no data
              return const Text('No data');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
