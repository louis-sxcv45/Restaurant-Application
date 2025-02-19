import 'package:flutter/material.dart';
import 'package:gastro_go_app/model/data/database_service/local_database_service.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';

class FavoriteRestaurantProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  FavoriteRestaurantProvider(this._service);

  String _message = " ";
  String get message => _message;

  List<RestaurantData>? _restaurantList;
  List<RestaurantData>? get restaurantList => _restaurantList;

  RestaurantData? _restaurantData;
  RestaurantData? get restaurantData => _restaurantData;

  Future<void> saveRestaurant(RestaurantData value) async {
    try {
      final result = await _service.insertItem(value);

      final isError = result == 0;

      if (isError) {
        _message = "Failed to add your favorite";
        debugPrint("Failed to add your favorite: $_message");
      } else {
        _message = "Your favorite is successfully added";
        debugPrint("Your favorite is successfully added: $_message");
      }
      notifyListeners();
    } catch (e) {
      _message = "Failed to add your favorite";
      notifyListeners();
    }
  }

  Future<void> loadAllFavorite() async {
    try {
      _restaurantList = await _service.getAllData();
      _message = "Your favorite is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your favorite";
      notifyListeners();
    }
  }

  Future<void> loadFavoriteById(String id) async {
    try {
      _restaurantData = await _service.getDataId(id);
      _message = "Your favorite is loaded";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load your favorite";
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      await _service.removeItem(id);
      _message = "Your favorite is removed";
      debugPrint("message: $_message");
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove your favorite";
      notifyListeners();
    }
  }

  bool checkItemFavorite(String id) {
    final isSameFavorite = _restaurantData?.id == id;
    return isSameFavorite;
  }
}
