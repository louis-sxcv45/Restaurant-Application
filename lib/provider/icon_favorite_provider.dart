import 'package:flutter/material.dart';

class IconFavoriteProvider extends ChangeNotifier{
  bool _isFavoriteButton = false;

  bool get isFavoriteButton => _isFavoriteButton;

  set setIsFavorite(bool value) {
    _isFavoriteButton = value;
    notifyListeners();
  }
}