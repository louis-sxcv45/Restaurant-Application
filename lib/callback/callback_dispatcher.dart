import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:gastro_go_app/model/api/api_service.dart';
import 'package:gastro_go_app/notification_service/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().executeTask((task, inputData) async {
    final localNotificationService = LocalNotificationService();
    await localNotificationService.init();
    await localNotificationService.requestPermission();
    await localNotificationService.configureLocalTimeZone();

    final apiService = ApiService();
    final restaurantResponse = await apiService.getRestaurantList();
    final restaurants = restaurantResponse.restaurant;

    if (restaurants.isNotEmpty) {
      final random = Random();
      final randomRestaurant = restaurants[random.nextInt(restaurants.length)];

      const title = "Lunch Reminder";
      final body = "Coba makan di Restaurant ${randomRestaurant.name}!";

      await localNotificationService.scheduleDailyNotification(
        id: randomRestaurant.id.hashCode,
        title: title,
        body: body,
        payload: randomRestaurant.id,
      );
    }
    return Future.value(true);
  });
}
