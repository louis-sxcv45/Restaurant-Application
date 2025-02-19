import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gastro_go_app/model/api/api_service.dart';
import 'package:gastro_go_app/static/restaurant_review_state.dart';

class RestaurantReviewProvider extends ChangeNotifier{
  final ApiService _apiService;
  
  RestaurantReviewProvider(this._apiService);

  RestaurantReviewState _resultState = RestaurantReviewNoneState();
  RestaurantReviewState get resultState => _resultState;


  Future<void> addReview(String id, String name, String customerReview) async{
    try {
      _resultState = RestaurantReviewLoadingState();
      notifyListeners();

      final result = await _apiService.postReview(id, name, customerReview);

      if(result.error) {
        _resultState = RestaurantReviewErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantReviewLoadedState(result.customerReviews);
        notifyListeners();
      }
    } on Exception catch(e) {
      _resultState = RestaurantReviewErrorState(e.toString());
      notifyListeners();
    }
  }
  
}