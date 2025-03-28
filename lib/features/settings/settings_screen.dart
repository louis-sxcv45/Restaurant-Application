import 'package:flutter/material.dart';
import 'package:gastro_go_app/provider/change_theme_provider.dart';
import 'package:gastro_go_app/provider/daily_reminder_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Theme Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<ChangeThemeProvider>(
              builder: (context, theme, child) {
                return SwitchListTile(
                  title: const Text('Dark Theme'),
                  value: theme.isDark,
                  onChanged: (value) {
                    theme.changeTheme();
                  },
                );
              },
            ),
            const Text(
              'Notification Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Consumer<DailyReminderProvider>(
              builder: (context, notification, child) {
                return SwitchListTile(
                  title: const Text("Daily Reminder"),
                  subtitle: const Text(
                    "Aktifkan pengingat makan siang setiap hari pukul 11:00 AM",
                  ),
                  value: notification.isDailyReminderEnabled,
                  onChanged: (value) {
                    notification.toggleDailyReminder(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
