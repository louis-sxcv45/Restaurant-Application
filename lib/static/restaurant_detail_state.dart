import 'package:gastro_go_app/model/data/restaurant_detail_data/restaurant_detail.dart';

sealed class RestaurantDetailState {}

class RestaurantDetailNoneState extends RestaurantDetailState {}

class RestaurantDetailLoadingState extends RestaurantDetailState {}

class RestaurantDetailErrorState extends RestaurantDetailState {
  final String errorMessage;

  RestaurantDetailErrorState(this.errorMessage);
  String get message => errorMessage;
}

class RestaurantDetailLoadedState extends RestaurantDetailState {
  final RestaurantDetail data;

  RestaurantDetailLoadedState(this.data);
  RestaurantDetail get restaurant => data;
}
