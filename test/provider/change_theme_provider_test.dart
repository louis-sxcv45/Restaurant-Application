import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gastro_go_app/provider/change_theme_provider.dart';

void main() {
  group('ChangeThemeProvider', () {
    test('Initial state should be false (light mode) when no value is stored', () async {
      // Set nilai awal kosong untuk SharedPreferences.
      SharedPreferences.setMockInitialValues({});

      final provider = ChangeThemeProvider();
      // Beri waktu agar async themeState() pada konstruktor selesai.
      await Future.delayed(Duration.zero);

      expect(provider.isDark, false);
      expect(provider.currentThemeMode, ThemeMode.light);
    });

    test('Initial state should be true (dark mode) when stored value is true', () async {
      // Simulasikan kondisi SharedPreferences dengan nilai 'isDark' true.
      SharedPreferences.setMockInitialValues({'isDark': true});

      final provider = ChangeThemeProvider();
      await Future.delayed(Duration.zero);

      expect(provider.isDark, true);
      expect(provider.currentThemeMode, ThemeMode.dark);
    });

    test('changeTheme() toggles theme and updates SharedPreferences', () async {
      // Set nilai awal dengan 'isDark' false.
      SharedPreferences.setMockInitialValues({'isDark': false});

      final provider = ChangeThemeProvider();
      await Future.delayed(Duration.zero);

      expect(provider.isDark, false);
      expect(provider.currentThemeMode, ThemeMode.light);

      // Panggil changeTheme untuk mengubah tema ke dark mode.
      await provider.changeTheme();
      expect(provider.isDark, true);
      expect(provider.currentThemeMode, ThemeMode.dark);

      // Verifikasi nilai tersimpan di SharedPreferences.
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('isDark'), true);

      // Panggil changeTheme lagi untuk mengubah kembali ke light mode.
      await provider.changeTheme();
      expect(provider.isDark, false);
      expect(provider.currentThemeMode, ThemeMode.light);
      expect(prefs.getBool('isDark'), false);
    });
  });
}
