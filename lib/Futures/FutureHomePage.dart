import 'package:flutter/material.dart';

class FutureHomePage extends StatefulWidget {
  const FutureHomePage({super.key});

  @override
  _FutureHomePageState createState() => _FutureHomePageState();
}

class _FutureHomePageState extends State<FutureHomePage> {
  int _counter = 0; // Initialize the counter

  // Simulated asynchronous operation to fetch initial counter value
  Future<int> fetchInitialCounterValue() async {
    // Simulate a network call or some asynchronous task
    await Future.delayed(const Duration(seconds: 2));
    return 10; // Return a sample initial counter value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Future"),
      ),
      body: Center(
        child: FutureBuilder<int>(
          future:
              fetchInitialCounterValue(), // Use the fetchInitialCounterValue Future
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}
