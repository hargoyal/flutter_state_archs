// counter_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

// Counter Event
abstract class CounterEvent {}

class IncrementCounter extends CounterEvent {}

class FetchInitialCounterValue extends CounterEvent {}

// Counter State
abstract class CounterState {
  final int counter;

  const CounterState(this.counter);
}

class CounterInitial extends CounterState {
  const CounterInitial() : super(0);
}

class CounterLoaded extends CounterState {
  const CounterLoaded(int counter) : super(counter);
}

// Counter BLoC
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterInitial()) {
    on<FetchInitialCounterValue>(_onFetchInitialCounterValue);
    on<IncrementCounter>(_onIncrementCounter);
  }

  Future<void> _onFetchInitialCounterValue(
    FetchInitialCounterValue event,
    Emitter<CounterState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(const CounterLoaded(10)); // Emit initial counter value
  }

  void _onIncrementCounter(
    IncrementCounter event,
    Emitter<CounterState> emit,
  ) {
    if (state is CounterLoaded) {
      final currentState = state as CounterLoaded;
      emit(CounterLoaded(currentState.counter + 1));
    }
  }
}
