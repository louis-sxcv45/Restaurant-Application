import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeProvider extends ChangeNotifier {
  late SharedPreferences prefs;
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeMode get currentThemeMode => _isDark ? ThemeMode.dark : ThemeMode.light;

  ChangeThemeProvider() {
    themeState();
  }

  Future<void> changeTheme() async {
    _isDark = !_isDark;
    await prefs.setBool('isDark', _isDark);
    notifyListeners();
  }

  Future<void> themeState() async {
    prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool('isDark') ?? isDark;
    notifyListeners();
  }
}
