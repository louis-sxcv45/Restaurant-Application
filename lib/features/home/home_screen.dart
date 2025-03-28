import 'package:flutter/material.dart';
import 'package:gastro_go_app/common_widgets/card_widget.dart';
import 'package:gastro_go_app/provider/restaurant_list_provider.dart';
import 'package:gastro_go_app/routes/navigation_routes.dart';
import 'package:gastro_go_app/static/restaurant_list_state.dart';
import 'package:gastro_go_app/styles_manager/values_manager.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  void onChanged(String value) {
    if (value.isNotEmpty) {
      context.read<RestaurantListProvider>().searchRestaurantList(value);
    } else {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('GastroGo'))),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: AppSize.s14),
              decoration: const InputDecoration(
                hintText: 'Search Restaurant...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s10)),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: onChanged,
            ),
          ),
          Expanded(
            child: Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (value.resultState is RestaurantErrorState) {
                    final message =
                        (value.resultState as RestaurantErrorState)
                            .errorMessage;

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
                  }
                });
                return switch (value.resultState) {
                  RestaurantLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  RestaurantErrorState() => const Center(
                    child: Text('An unexpected error occurred. Try it again'),
                  ),
                  RestaurantLoadedState(data: var restaurant) =>
                    restaurant.isNotEmpty
                        ? CustomScrollView(
                          slivers: [
                            SliverList.builder(
                              itemCount: restaurant.length,
                              itemBuilder: (context, index) {
                                final dataRestaurant = restaurant[index];
                                return CardWidget(
                                  index: index,
                                  source: 'home',
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
                        )
                        : const Center(child: Text('Data Not Found')),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.clear();
    super.dispose();
  }
}
