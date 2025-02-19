import 'dart:convert';
import 'package:gastro_go_app/model/data/customer_review/customer_review_response.dart';
import 'package:gastro_go_app/model/data/restaurant_detail_data/restaurant_detail_response.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_list_response.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_search_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantListResponse> getRestaurantList() async{
    final response = await http.get(Uri.parse('$_baseUrl/list'));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }


  Future<CustomerReviewResponse> postReview(String id, String name, String reviews) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": id, "name": name, "review": reviews}),
    );

    if (response.statusCode == 200) {
      return CustomerReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to post review");
    }
  }
}