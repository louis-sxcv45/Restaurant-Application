import 'package:flutter_test/flutter_test.dart';
import 'package:gastro_go_app/model/data/database_service/local_database_service.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';
import 'package:gastro_go_app/provider/favorite_restaurant_provider.dart';

final dummyRestaurant = RestaurantData(
  id: "1",
  name: "Test Restaurant",
  description: "A test restaurant",
  pictureId: "pic1",
  city: "Test City",
  rating: 4.5,
);

class FakeLocalDatabaseServiceSuccess implements LocalDatabaseService {
  @override
  Future<int> insertItem(RestaurantData restaurant) async {
    return 1;
  }

  @override
  Future<List<RestaurantData>> getAllData() async {
    return [dummyRestaurant];
  }

  @override
  Future<RestaurantData> getDataId(String id) async {
    return dummyRestaurant;
  }

  @override
  Future<String> removeItem(String id) async {
    return "1";
  }

  @override
  Future<void> createTables(dynamic database) async {
  }
  
  // ignore: unused_element
  Future<dynamic> _intializeDb() async {
  }
}

class FakeLocalDatabaseServiceFailure implements LocalDatabaseService {
  @override
  Future<int> insertItem(RestaurantData restaurant) async {
    return 0;
  }

  @override
  Future<List<RestaurantData>> getAllData() async {
    throw Exception("Failed to load favorites");
  }

  @override
  Future<RestaurantData> getDataId(String id) async {
    throw Exception("Failed to load favorite by id");
  }

  @override
  Future<String> removeItem(String id) async {
    throw Exception("Failed to remove favorite");
  }

  @override
  Future<void> createTables(dynamic database) async {
  }
  
  // ignore: unused_element
  Future<dynamic> _intializeDb() async {
  }
}

void main() {
  group('FavoriteRestaurantProvider - saveRestaurant', () {
    test('Sukses: Pesan harus "Your favorite is successfully added"', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceSuccess());
      await provider.saveRestaurant(dummyRestaurant);
      expect(provider.message, "Your favorite is successfully added");
    });

    test('Gagal: Pesan harus "Failed to add your favorite"', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceFailure());
      await provider.saveRestaurant(dummyRestaurant);
      expect(provider.message, "Failed to add your favorite");
    });
  });

  group('FavoriteRestaurantProvider - loadAllFavorite', () {
    test('Sukses: Harus mengembalikan daftar favorit dan pesan "Your favorite is loaded"', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceSuccess());
      await provider.loadAllFavorite();
      expect(provider.restaurantList, isNotNull);
      expect(provider.restaurantList!.isNotEmpty, true);
      expect(provider.message, "Your favorite is loaded");
    });

    test('Gagal: Pesan harus "Failed to load your favorite"', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceFailure());
      await provider.loadAllFavorite();
      expect(provider.message, "Failed to load your favorite");
    });
  });

  group('FavoriteRestaurantProvider - loadFavoriteById', () {
    test('Sukses: Harus mengembalikan data favorit dan pesan "Your favorite is loaded"', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceSuccess());
      await provider.loadFavoriteById(dummyRestaurant.id);
      expect(provider.restaurantData, isNotNull);
      expect(provider.restaurantData!.id, dummyRestaurant.id);
      expect(provider.message, "Your favorite is loaded");
    });

    test('Gagal: Pesan harus "Failed to load your favorite"', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceFailure());
      await provider.loadFavoriteById(dummyRestaurant.id);
      expect(provider.message, "Failed to load your favorite");
    });
  });

  group('FavoriteRestaurantProvider - removeFavorite', () {
    test('Sukses: Pesan harus "Your favorite is removed"', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceSuccess());
      await provider.removeFavorite(dummyRestaurant.id);
      expect(provider.message, "Your favorite is removed");
    });

    test('Gagal: Pesan harus "Failed to remove your favorite"', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceFailure());
      await provider.removeFavorite(dummyRestaurant.id);
      expect(provider.message, "Failed to remove your favorite");
    });
  });

  group('FavoriteRestaurantProvider - checkItemFavorite', () {
    test('Harus mengembalikan true jika id sama dengan restaurantData', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceSuccess());
      // Simulasi data yang telah dimuat
      provider.loadFavoriteById(dummyRestaurant.id);
      // Karena loadFavoriteById bersifat asynchronous, kita tunggu penyelesaiannya.
      await Future.delayed(const Duration(milliseconds: 10));
      expect(provider.checkItemFavorite(dummyRestaurant.id), true);
    });

    test('Harus mengembalikan false jika id tidak sama dengan restaurantData', () async {
      final provider = FavoriteRestaurantProvider(FakeLocalDatabaseServiceSuccess());
      provider.loadFavoriteById(dummyRestaurant.id);
      await Future.delayed(const Duration(milliseconds: 10));
      expect(provider.checkItemFavorite("non_existing_id"), false);
    });
  });
}
