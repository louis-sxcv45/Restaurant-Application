import 'package:gastro_go_app/model/data/restaurant_detail_data/category_restaurant.dart';
import 'package:gastro_go_app/model/data/restaurant_detail_data/customer_review.dart';
import 'package:gastro_go_app/model/data/restaurant_detail_data/menu_restaurant.dart';

class RestaurantDetail {
    String id;
    String name;
    String description;
    String city;
    String address;
    String pictureId;
    double rating;
    List<Category> categories;
    Menus menus;
    List<CustomerReview> customerReviews;

    RestaurantDetail({
        required this.id,
        required this.name,
        required this.description,
        required this.city,
        required this.address,
        required this.pictureId,
        required this.categories,
        required this.rating,
        required this.menus,
        required this.customerReviews,
    });

    factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        rating: json["rating"]?.toDouble(),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );
}