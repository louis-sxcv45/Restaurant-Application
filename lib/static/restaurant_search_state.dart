import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';

sealed class RestaurantSearchState {}

class RestaurantSearchNoneState extends RestaurantSearchState {}

class RestaurantSearchLoadingState extends RestaurantSearchState {}

class RestaurantSearchErrorState extends RestaurantSearchState {
  final String errorMessage;

  RestaurantSearchErrorState(this.errorMessage);
}

class RestaurantSearchLoadedState extends RestaurantSearchState {
  final List<RestaurantData> data;

  RestaurantSearchLoadedState(this.data);
}
