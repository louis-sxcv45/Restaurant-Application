class RestaurantData {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  RestaurantData({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: (json["rating"] ?? 0.0).toDouble(),
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }
}
