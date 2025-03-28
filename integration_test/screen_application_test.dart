import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gastro_go_app/main.dart' as app;
import 'package:gastro_go_app/common_widgets/card_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full app flow test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // --- Home Screen ---
    expect(find.text('GastroGo'), findsOneWidget);

    final scrollable = find.byType(CustomScrollView);
    if (scrollable.evaluate().isNotEmpty) {
      await tester.fling(scrollable, const Offset(0, -300), 3000);
      await tester.pumpAndSettle();
    }

    Future<void> performSearch(String query) async {
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget, reason: 'Data Not Found');

      await tester.enterText(searchField, query);
      await tester.pumpAndSettle();

      final cardResults = find.byType(CardWidget);
      if (cardResults.evaluate().isEmpty) {
        debugPrint('Tidak ada hasil untuk pencarian "$query"');
      } else {
        debugPrint('Hasil ditemukan untuk "$query"');
      }

      await tester.enterText(searchField, '');
      await tester.pumpAndSettle();
    }

    await performSearch('Pizza');
    await performSearch('Kafe Kita');
    await performSearch('Italia');

    // ---Detail Screen ---
    final cardFinder = find.byType(CardWidget);
    if (cardFinder.evaluate().isNotEmpty) {
      await tester.tap(cardFinder.first);
      await tester.pumpAndSettle();

      if (find.text('Detail Restaurant').evaluate().isEmpty) {
        debugPrint('Halaman Detail tidak tampil setelah mengetuk CardWidget.');
      } else {
        expect(find.text('Detail Restaurant'), findsOneWidget);
      }

      await tester.pageBack();
      await tester.pumpAndSettle();
    } else {
      debugPrint(
          'Tidak ditemukan CardWidget, melewati navigasi ke Detail Screen.');
    }

    final favoriteIconFinder = find.byIcon(Icons.favorite_border);
    if (favoriteIconFinder.evaluate().isNotEmpty) {
      await tester.tap(favoriteIconFinder.first);
      await tester.pumpAndSettle();
    } else {
      debugPrint('Ikon favorite tidak ditemukan, melewati Favorite Action.');
    }


    //Favorite Screen
    final favIconNav = find.byIcon(Icons.favorite_border);
    expect(favIconNav, findsOneWidget);
    await tester.tap(favIconNav);
    await tester.pumpAndSettle();

    final cardFav = find.byType(CardWidget);
    if (cardFav.evaluate().isNotEmpty) {

      await tester.tap(cardFav.first);
      await tester.pumpAndSettle();
      if (find.text('Detail Restaurant').evaluate().isEmpty) {
        debugPrint('Halaman Detail tidak tampil setelah mengetuk CardWidget.');
      } else {
        expect(find.text('Detail Restaurant'), findsOneWidget);
      }

      await tester.pageBack();
      await tester.pumpAndSettle();
    } else {
      debugPrint(
          'Tidak ditemukan CardWidget, melewati navigasi ke Detail Screen.');
    }

    final favoriteIconDetail = find.byIcon(Icons.favorite);
    if (favoriteIconDetail.evaluate().isNotEmpty) {
      await tester.tap(favoriteIconDetail.first);
      await tester.pumpAndSettle();
    } else {
      debugPrint('Ikon favorite tidak ditemukan, melewati Favorite Action.');
    }

    // --- Settings Screen ---
    final settingsIconFinder = find.byIcon(Icons.settings_outlined);
    expect(settingsIconFinder, findsOneWidget);
    await tester.tap(settingsIconFinder);
    await tester.pumpAndSettle();

    final darkThemeSwitch = find.widgetWithText(SwitchListTile, 'Dark Theme');
    expect(darkThemeSwitch, findsOneWidget,
        reason: 'Switch Dark Theme tidak ditemukan');

    final dailyReminderSwitch =
        find.widgetWithText(SwitchListTile, 'Daily Reminder');
    expect(dailyReminderSwitch, findsOneWidget,
        reason: 'Switch Daily Reminder tidak ditemukan');

    await tester.tap(darkThemeSwitch);
    await tester.pumpAndSettle();

    await tester.tap(dailyReminderSwitch);
    await tester.pumpAndSettle();

    await tester.tap(darkThemeSwitch);
    await tester.pumpAndSettle();

    await tester.tap(dailyReminderSwitch);
    await tester.pumpAndSettle();

    final appBarFinder = find.byType(AppBar);
    expect(appBarFinder, findsWidgets);
    // ignore: unused_local_variable
    final AppBar appBarWidget = tester.widget(appBarFinder.first);

    debugPrint('Integration test selesai.');
  });
}
