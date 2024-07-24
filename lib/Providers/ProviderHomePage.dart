import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CounterNotifier.dart';

class ProviderHomePage extends StatelessWidget {
  const ProviderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch the initial counter value after the first build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ensure this only runs once after the build method completes
      context.read<CounterNotifier>().fetchInitialCounterValue();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Provider"),
      ),
      body: Center(
        child: Consumer<CounterNotifier>(
          builder: (context, counterNotifier, child) {
            // Display a loading indicator while fetching the initial counter value
            if (counterNotifier.counter == 0) {
              return const CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '${counterNotifier.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterNotifier>().incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
