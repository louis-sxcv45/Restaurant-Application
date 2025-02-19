import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';

class RestaurantSearchResponse {
    bool error;
    int founded;
    List<RestaurantData> restaurants;

    RestaurantSearchResponse({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) => RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantData>.from(json["restaurants"].map((x) => RestaurantData.fromJson(x))),
    );
}