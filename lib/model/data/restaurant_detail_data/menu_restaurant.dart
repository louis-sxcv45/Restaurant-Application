import 'package:gastro_go_app/model/data/restaurant_detail_data/category_restaurant.dart';

class Menus {
  List<Category> foods;
  List<Category> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
    drinks: List<Category>.from(
      json["drinks"].map((x) => Category.fromJson(x)),
    ),
  );
}
