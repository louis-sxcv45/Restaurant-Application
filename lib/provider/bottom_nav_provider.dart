import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int _indexNav = 0;

  int get indexNav => _indexNav;

  void setIndexNav(int index) {
    _indexNav = index;
    notifyListeners();

    debugPrint('index: $index');
  }
}
