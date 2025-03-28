import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';

sealed class RestaurantListState {}

class RestaurantNoneState extends RestaurantListState {}

class RestaurantLoadingState extends RestaurantListState {}

class RestaurantErrorState extends RestaurantListState {
  final String errorMessage;

  RestaurantErrorState(this.errorMessage);

  String get message => errorMessage;
}

class RestaurantLoadedState extends RestaurantListState {
  final List<RestaurantData> data;

  RestaurantLoadedState(this.data);
  List<RestaurantData> get restaurants => data;
}
