import 'package:flutter/cupertino.dart';

class CounterNotifier extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  Future<void> fetchInitialCounterValue() async {
    await Future.delayed(const Duration(seconds: 2));
    _counter = 10;
    notifyListeners();
  }
}
