import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart'; // Ensure this import is correct

class BlocHomePage extends StatelessWidget {
  const BlocHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("BLoC"),
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            if (state is CounterInitial) {
              return const CircularProgressIndicator();
            } else if (state is CounterLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              );
            } else {
              return const Text('Unknown state');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterBloc>().add(IncrementCounter()),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
