import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:gastro_go_app/features/settings/settings_screen.dart';
import 'package:gastro_go_app/provider/change_theme_provider.dart';
import 'package:gastro_go_app/provider/daily_reminder_provider.dart';

/// Fake provider untuk ChangeThemeProvider.
class FakeChangeThemeProvider extends ChangeThemeProvider {
  // Kita override properti untuk testing.
  bool _fakeIsDark = false;
  @override
  bool get isDark => _fakeIsDark;

  @override
  Future<void> changeTheme() async {
    _fakeIsDark = !_fakeIsDark;
    notifyListeners();
  }

  @override
  Future<void> themeState() async {
    // Tidak melakukan inisialisasi SharedPreferences.
    _fakeIsDark = false;
    notifyListeners();
  }
}

/// Fake provider untuk DailyReminderProvider.
class FakeDailyReminderProvider extends ChangeNotifier implements DailyReminderProvider {
  bool _isEnabled = false;
  @override
  bool get isDailyReminderEnabled => _isEnabled;

  @override
  Future<void> toggleDailyReminder(bool value) async {
    _isEnabled = value;
    notifyListeners();
  }
}

void main() {
  group('SettingsScreen Widget Tests', () {
    testWidgets('Menampilkan teks dan switch yang tepat serta dapat men-toggle switch', (WidgetTester tester) async {
      // Inisialisasi fake provider.
      final fakeThemeProvider = FakeChangeThemeProvider();
      final fakeDailyReminderProvider = FakeDailyReminderProvider();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ChangeThemeProvider>.value(value: fakeThemeProvider),
            ChangeNotifierProvider<DailyReminderProvider>.value(value: fakeDailyReminderProvider),
          ],
          child: const MaterialApp(home: SettingsScreen()),
        ),
      );

      // Verifikasi tampilan teks.
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Theme Settings'), findsOneWidget);
      expect(find.text('Dark Theme'), findsOneWidget);
      expect(find.text('Notification Settings'), findsOneWidget);
      expect(find.text('Daily Reminder'), findsOneWidget);
      expect(find.text('Aktifkan pengingat makan siang setiap hari pukul 11:00 AM'), findsOneWidget);

      // Cari SwitchListTile untuk tema dan notifikasi.
      final darkThemeSwitch = tester.widget<SwitchListTile>(
        find.widgetWithText(SwitchListTile, 'Dark Theme'),
      );
      expect(darkThemeSwitch.value, isFalse);

      final dailyReminderSwitch = tester.widget<SwitchListTile>(
        find.widgetWithText(SwitchListTile, 'Daily Reminder'),
      );
      expect(dailyReminderSwitch.value, isFalse);

      // Tap pada switch Dark Theme.
      await tester.tap(find.widgetWithText(SwitchListTile, 'Dark Theme'));
      await tester.pumpAndSettle();
      expect(fakeThemeProvider.isDark, isTrue);

      // Tap pada switch Daily Reminder.
      await tester.tap(find.widgetWithText(SwitchListTile, 'Daily Reminder'));
      await tester.pumpAndSettle();
      expect(fakeDailyReminderProvider.isDailyReminderEnabled, isTrue);
    });
  });
}
