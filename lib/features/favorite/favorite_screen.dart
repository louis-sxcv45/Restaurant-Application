import 'package:flutter/material.dart';
import 'package:gastro_go_app/common_widgets/card_widget.dart';
import 'package:gastro_go_app/provider/favorite_restaurant_provider.dart';
import 'package:gastro_go_app/routes/navigation_routes.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<FavoriteRestaurantProvider>().loadAllFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Restaurant')),
      body: Consumer<FavoriteRestaurantProvider>(
        builder: (context, value, child) {
          final listFavorite = value.restaurantList ?? [];
          return switch (listFavorite.isNotEmpty) {
            true => CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: listFavorite.length,
                  itemBuilder: (context, index) {
                    final dataRestaurant = listFavorite[index];
                    return CardWidget(
                      index: index,
                      source: 'favorite',
                      restaurantData: dataRestaurant,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          NavigationRoutes.detailRoute.name,
                          arguments: dataRestaurant.id,
                        );
                      },
                      name: dataRestaurant.name,
                      image: dataRestaurant.pictureId,
                      city: dataRestaurant.city,
                      rating: dataRestaurant.rating,
                    );
                  },
                ),
              ],
            ),
            _ => const Center(child: Text('Data Not Found')),
          };
        },
      ),
    );
  }
}
