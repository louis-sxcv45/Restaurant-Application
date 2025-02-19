import 'package:flutter/material.dart';
import 'package:gastro_go_app/model/api/api_service.dart';
import 'package:gastro_go_app/static/restaurant_detail_state.dart';

class RestaurantDetailProvider extends ChangeNotifier{
  final ApiService _apiService;

  RestaurantDetailProvider(this._apiService);

  RestaurantDetailState _resultState = RestaurantDetailNoneState();
  RestaurantDetailState get resultState => _resultState;

  Future<void> getRestaurantDetail(String id) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiService.getRestaurantDetail(id);

      if(result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch(e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}