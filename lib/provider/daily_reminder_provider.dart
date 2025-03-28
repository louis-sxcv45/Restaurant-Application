import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class DailyReminderProvider extends ChangeNotifier {
  bool _isDailyReminderEnabled = false;
  bool get isDailyReminderEnabled => _isDailyReminderEnabled;

  static const String dailyReminderKey = "dailyReminderEnabled";

  DailyReminderProvider() {
    _loadDailyReminderPreference();
  }

  Future<void> _loadDailyReminderPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDailyReminderEnabled = prefs.getBool(dailyReminderKey) ?? false;
    notifyListeners();
  }

  Future<void> toggleDailyReminder(bool value) async {
    _isDailyReminderEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(dailyReminderKey, value);

    if (value) {
      final delay =
          kDebugMode ? const Duration(seconds: 10) : _calculateInitialDelay();
      await Workmanager().registerPeriodicTask(
        "dailyReminderTask",
        "dailyReminder",
        frequency: const Duration(hours: 24),
        initialDelay: delay,
        constraints: Constraints(networkType: NetworkType.connected),
      );
      debugPrint(
        "Daily Reminder diaktifkan. Task WorkManager terdaftar. Notifikasi berikutnya akan muncul dalam ${delay.inSeconds} detik.",
      );
    } else {
      await Workmanager().cancelByUniqueName("dailyReminderTask");
      debugPrint("Daily Reminder dinonaktifkan. Task WorkManager dibatalkan.");
    }
    notifyListeners();
  }

  Duration _calculateInitialDelay() {
    final now = DateTime.now();
    final nextElevenAM = DateTime(now.year, now.month, now.day, 11, 0);
    if (now.isAfter(nextElevenAM)) {
      return nextElevenAM.add(const Duration(days: 1)).difference(now);
    }
    return nextElevenAM.difference(now);
  }
}
