import 'package:gastro_go_app/model/data/restaurant_detail_data/restaurant_detail.dart';

class RestaurantDetailResponse {
  bool error;
  String message;
  RestaurantDetail restaurants;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurants: RestaurantDetail.fromJson(json["restaurant"]),
      );
}
