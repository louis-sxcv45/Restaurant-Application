import 'package:flutter/material.dart';

class IconFavoriteProvider extends ChangeNotifier {
  final Map<String, bool> _favoriteStatus = {};

  bool isFavorite(String restaurantId) {
    return _favoriteStatus[restaurantId] ?? false;
  }

  void setFavorite(String restaurantId, bool value) {
    _favoriteStatus[restaurantId] = value;
    notifyListeners();
  }
}
