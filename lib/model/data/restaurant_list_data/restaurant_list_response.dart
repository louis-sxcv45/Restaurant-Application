import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';

class RestaurantListResponse {
    bool error;
    String message;
    int count;
    List<RestaurantData> restaurant;

    RestaurantListResponse({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurant,
    });

    factory RestaurantListResponse.fromJson(Map<String, dynamic> json) => RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurant: List<RestaurantData>.from(json["restaurants"].map((x) => RestaurantData.fromJson(x))),
    );
}