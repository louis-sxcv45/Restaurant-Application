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
    super.initState();
    Future.microtask(() async {
      // ignore: use_build_context_synchronously
      final favoriteProvider = context.read<FavoriteRestaurantProvider>();
      // ignore: use_build_context_synchronously
      final iconFavoriteProvider = context.read<IconFavoriteProvider>();

      await favoriteProvider.loadFavoriteById(widget.restaurantData.id);
      final value = favoriteProvider.checkItemFavorite(
        widget.restaurantData.id,
      );

      iconFavoriteProvider.setFavorite(widget.restaurantData.id, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final iconFavoriteProvider = context.watch<IconFavoriteProvider>();
    final isFavorite = iconFavoriteProvider.isFavorite(
      widget.restaurantData.id,
    );

    return IconButton(
      onPressed: () async {
        final favoriteProvider = context.read<FavoriteRestaurantProvider>();
        final iconFavoriteProvider = context.read<IconFavoriteProvider>();

        final currentFavorite = iconFavoriteProvider.isFavorite(
          widget.restaurantData.id,
        );

        if (currentFavorite) {
          await favoriteProvider.removeFavorite(widget.restaurantData.id);
        } else {
          await favoriteProvider.saveRestaurant(widget.restaurantData);
        }

        iconFavoriteProvider.setFavorite(
          widget.restaurantData.id,
          !currentFavorite,
        );
        favoriteProvider.loadAllFavorite();
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: const Color.fromARGB(255, 236, 6, 6),
      ),
    );
  }
}
