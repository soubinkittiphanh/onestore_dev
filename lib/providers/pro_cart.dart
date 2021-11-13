import 'package:flutter/material.dart';

class ProCart extends ChangeNotifier {
  int countProvider = 0;
  void increateState() {
    countProvider += 1;
    print('increase: ' + countProvider.toString());
    notifyListeners();
  }

  int get statePro => countProvider;
  void decreaseState() {
    countProvider -= 1;
    notifyListeners();
  }
}
