import 'package:flutter_test/flutter_test.dart';
import 'package:gastro_go_app/model/api/api_service.dart';
import 'package:gastro_go_app/model/data/customer_review/customer_review_response.dart';
import 'package:gastro_go_app/model/data/restaurant_detail_data/restaurant_detail_response.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_list_response.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_search_response.dart';
import 'package:gastro_go_app/provider/restaurant_list_provider.dart';
import 'package:gastro_go_app/static/restaurant_list_state.dart';

class FakeApiServiceSuccess implements ApiService {
  @override
  Future<RestaurantListResponse> getRestaurantList() async {
    return RestaurantListResponse(
      error: false,
      message: 'success',
      count: 1,
      restaurant: [RestaurantData(
        id: "1",
        pictureId: "3",
        description: "Korean BBQ",
        city: "Jakarta",
        rating: 4.5,
        name: 'Test Restaurant')],
    );
  }

  @override
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async => throw UnimplementedError();
  
  @override
  Future<RestaurantSearchResponse> searchRestaurant(String query) async => throw UnimplementedError();

  @override
  Future<CustomerReviewResponse> postReview(String id, String name, String reviews) {
    throw UnimplementedError();
  }
}

class FakeApiServiceFailure implements ApiService {
  @override
  Future<RestaurantListResponse> getRestaurantList() async {
    return RestaurantListResponse(
      error: true,
      message: 'Failed to fetch',
      count: 0,
      restaurant: [],
    );
  }

  @override
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async => throw UnimplementedError();
  
  @override
  Future<RestaurantSearchResponse> searchRestaurant(String query) async => throw UnimplementedError();

  @override
  Future<CustomerReviewResponse> postReview(String id, String name, String reviews) {
    throw UnimplementedError();
  }
}

class FakeApiServiceSearchSuccess implements ApiService {
  @override
  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    return RestaurantSearchResponse(
      error: false,
      founded: 1,
      restaurants: [RestaurantData.fromJson({
        "id": "1",
        "pictureId": "3",
        "description": "Korean BBQ",
        "city": "Jakarta",
        "rating": 4.5,
        "name": 'Test Restaurant'
      })],
    );
  }

  @override
  Future<RestaurantListResponse> getRestaurantList() async => throw UnimplementedError();
  
  @override
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async => throw UnimplementedError();

  @override
  Future<CustomerReviewResponse> postReview(String id, String name, String reviews) {
    throw UnimplementedError();
  }
}

class FakeApiServiceSearchFailure implements ApiService {
  @override
  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    return RestaurantSearchResponse(
      error: true,
      founded: 0,
      restaurants: [],
    );
  }

  @override
  Future<RestaurantListResponse> getRestaurantList() async => throw UnimplementedError();
  
  @override
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async => throw UnimplementedError();

  @override
  Future<CustomerReviewResponse> postReview(String id, String name, String reviews) {

    throw UnimplementedError();
  }
}

void main() {
  group('RestaurantListProvider - initial state', () {
    test('Unit Test: Initial state harus RestaurantNoneState', () {
      final provider = RestaurantListProvider(FakeApiServiceSuccess());
      expect(provider.resultState, isA<RestaurantNoneState>());
    });
  });

  group('RestaurantListProvider - fetchRestaurantList', () {
    test('Unit Test: Mengembalikan RestaurantLoadedState ketika API berhasil', () async {
      final provider = RestaurantListProvider(FakeApiServiceSuccess());
      await provider.fetchRestaurantList();
      expect(provider.resultState, isA<RestaurantLoadedState>());
      final loadedState = provider.resultState as RestaurantLoadedState;
      expect(loadedState.restaurants.isNotEmpty, true);
    });

    test('Unit Test: Mengembalikan RestaurantErrorState ketika API gagal', () async {
      final provider = RestaurantListProvider(FakeApiServiceFailure());
      await provider.fetchRestaurantList();
      expect(provider.resultState, isA<RestaurantErrorState>());
      final errorState = provider.resultState as RestaurantErrorState;
      expect(errorState.message, 'Failed to fetch');
    });
  });
}