import 'package:flutter/material.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';
import 'package:gastro_go_app/provider/favorite_restaurant_provider.dart';
import 'package:gastro_go_app/provider/icon_favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final RestaurantData restaurantData;
  const FavoriteIconWidget({super.key, required this.restaurantData});

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {

  @override
  void initState() {
    final favoriteProvider = context.read<FavoriteRestaurantProvider>();
    final iconFavorite = context.read<IconFavoriteProvider>();

    Future.microtask(() async {
      await favoriteProvider.loadFavoriteById(widget.restaurantData.id);
      final value = favoriteProvider.checkItemFavorite(widget.restaurantData.id);
      
      iconFavorite.setIsFavorite = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final favoriteProvider = context.read<FavoriteRestaurantProvider>();
        final iconFavorite = context.read<IconFavoriteProvider>();

        final isFavorite = iconFavorite.isFavoriteButton;

        if (isFavorite) {
          await favoriteProvider.removeFavorite(widget.restaurantData.id);
        } else {
          await favoriteProvider.saveRestaurant(widget.restaurantData);
        }

        iconFavorite.setIsFavorite = !isFavorite;
        favoriteProvider.loadAllFavorite();
      },
      icon: Icon(
        color: Colors.red,
        context.watch<IconFavoriteProvider>().isFavoriteButton ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
}