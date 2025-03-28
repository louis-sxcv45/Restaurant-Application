import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gastro_go_app/provider/icon_favorite_provider.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:gastro_go_app/common_widgets/card_widget.dart';
import 'package:gastro_go_app/features/home/home_screen.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';
import 'package:gastro_go_app/provider/favorite_restaurant_provider.dart';
import 'package:gastro_go_app/provider/restaurant_list_provider.dart';
import 'package:gastro_go_app/static/restaurant_list_state.dart';
import 'package:provider/provider.dart';

class FakeRestaurantListProvider extends ChangeNotifier
    implements RestaurantListProvider {
  final RestaurantListState _state;
  FakeRestaurantListProvider(this._state);

  @override
  RestaurantListState get resultState => _state;

  @override
  Future<void> fetchRestaurantList() async {
  }

  @override
  Future<void> searchRestaurantList(String query) async {
  }
}

class FakeFavoriteRestaurantProvider extends ChangeNotifier
    implements FavoriteRestaurantProvider {
  final String _message = "";
  List<RestaurantData>? _restaurantList;
  RestaurantData? _restaurantData;

  @override
  String get message => _message;

  @override
  List<RestaurantData>? get restaurantList => _restaurantList;

  @override
  RestaurantData? get restaurantData => _restaurantData;

  @override
  Future<void> loadAllFavorite() async {
  }

  @override
  Future<void> loadFavoriteById(String id) async {
  }

  @override
  Future<void> removeFavorite(String id) async {
  }

  @override
  Future<void> saveRestaurant(RestaurantData value) async {
  }

  @override
  bool checkItemFavorite(String id) {
    return false;
  }
}

class FakeIconFavoriteProvider extends IconFavoriteProvider {
}

void main() {
  final dummyRestaurant = RestaurantData(
    id: "1",
    name: "Dummy Restaurant",
    description: "Dummy Description",
    pictureId: "dummy_pic",
    city: "Dummy City",
    rating: 4.2,
  );

  group('HomeScreen Widget Tests', () {
    testWidgets(
        'Menampilkan CircularProgressIndicator ketika state adalah RestaurantLoadingState',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        final fakeRestaurantListProvider =
            FakeRestaurantListProvider(RestaurantLoadingState());

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<RestaurantListProvider>.value(
                  value: fakeRestaurantListProvider),
              ChangeNotifierProvider<FavoriteRestaurantProvider>(
                create: (_) => FakeFavoriteRestaurantProvider(),
              ),
              ChangeNotifierProvider<IconFavoriteProvider>(
                create: (_) => FakeIconFavoriteProvider(),
              ),
            ],
            child: MaterialApp(
              home: Builder(builder: (context) => const HomeScreen()),
            ),
          ),
        );

        await tester.pump();
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    testWidgets(
        'Menampilkan error message ketika state adalah RestaurantErrorState',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        final fakeRestaurantListProvider =
            FakeRestaurantListProvider(RestaurantErrorState("Some error"));

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<RestaurantListProvider>.value(
                  value: fakeRestaurantListProvider),
              ChangeNotifierProvider<FavoriteRestaurantProvider>(
                create: (_) => FakeFavoriteRestaurantProvider(),
              ),
              ChangeNotifierProvider<IconFavoriteProvider>(
                create: (_) => FakeIconFavoriteProvider(),
              ),
            ],
            child: MaterialApp(
              home: Builder(builder: (context) => const HomeScreen()),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('An unexpected error occurred. Try it again'),
            findsOneWidget);
      });
    });

    testWidgets(
        'Menampilkan "Data Not Found" ketika RestaurantLoadedState dengan list kosong',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        final fakeRestaurantListProvider =
            FakeRestaurantListProvider(RestaurantLoadedState([]));

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<RestaurantListProvider>.value(
                  value: fakeRestaurantListProvider),
              ChangeNotifierProvider<FavoriteRestaurantProvider>(
                create: (_) => FakeFavoriteRestaurantProvider(),
              ),
              ChangeNotifierProvider<IconFavoriteProvider>(
                create: (_) => FakeIconFavoriteProvider(),
              ),
            ],
            child: MaterialApp(
              home: Builder(builder: (context) => const HomeScreen()),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('Data Not Found'), findsOneWidget);
      });
    });

    testWidgets(
        'Menampilkan list restoran ketika RestaurantLoadedState dengan data tersedia',
        (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        final fakeRestaurantListProvider =
            FakeRestaurantListProvider(RestaurantLoadedState([dummyRestaurant]));

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<RestaurantListProvider>.value(
                  value: fakeRestaurantListProvider),
              ChangeNotifierProvider<FavoriteRestaurantProvider>(
                create: (_) => FakeFavoriteRestaurantProvider(),
              ),
              ChangeNotifierProvider<IconFavoriteProvider>(
                create: (_) => FakeIconFavoriteProvider(),
              ),
            ],
            child: MaterialApp(
              home: Builder(builder: (context) => const HomeScreen()),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text(dummyRestaurant.name), findsOneWidget);
        expect(find.byType(CardWidget), findsOneWidget);
      });
    });
  });
}
