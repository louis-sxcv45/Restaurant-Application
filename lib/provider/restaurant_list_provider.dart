import 'package:flutter/material.dart';
import 'package:gastro_go_app/model/api/api_service.dart';
import 'package:gastro_go_app/static/restaurant_list_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService _apiService;

  RestaurantListProvider(this._apiService);

  RestaurantListState _resultState = RestaurantNoneState();
  RestaurantListState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantLoadedState(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantErrorState(e.toString());
      notifyListeners();
    }
  }

  Future<void> searchRestaurantList(String query) async {
    try {
      _resultState = RestaurantLoadingState();
      notifyListeners();

      final result = await _apiService.searchRestaurant(query);

      if (result.error) {
        String message = "Failed to search restaurant";
        _resultState = RestaurantErrorState(message);
        notifyListeners();
      } else {
        _resultState = RestaurantLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestaurantErrorState(e.toString());
      notifyListeners();
    }
  }
}
