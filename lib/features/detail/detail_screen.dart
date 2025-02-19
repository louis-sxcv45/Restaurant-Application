import 'package:flutter/material.dart';
import 'package:gastro_go_app/common_widgets/detail_screen_widget.dart';
import 'package:gastro_go_app/model/api/api_service.dart';
import 'package:gastro_go_app/provider/restaurant_detail_provider.dart';
import 'package:gastro_go_app/provider/restaurant_review_provider.dart';
import 'package:gastro_go_app/static/restaurant_detail_state.dart';
import 'package:gastro_go_app/static/restaurant_review_state.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({super.key, required this.restaurantId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    
    super.initState();
    Future.microtask((){
      // ignore: use_build_context_synchronously
      context.read<RestaurantDetailProvider>().getRestaurantDetail(widget.restaurantId);

      // ignore: use_build_context_synchronously
      context.read<RestaurantDetailProvider>().getRestaurantDetail(widget.restaurantId);

    });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RestaurantReviewProvider(
        context.read<ApiService>()
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Restaurant'),
        ),
        body: Consumer2<RestaurantDetailProvider, RestaurantReviewProvider>(
          builder: (context, detailProvider, reviewProvider, child) {
              if (detailProvider.resultState is RestaurantDetailLoadingState ||
                reviewProvider.resultState is RestaurantReviewLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return switch(detailProvider.resultState) {
              RestaurantDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ), 
              RestaurantDetailErrorState() => const Center(
                child: Text('An unexpected error occurred. Try it again'),
              ),
              RestaurantDetailLoadedState(data: var restaurantDetail) => DetailScreenWidget(
                data: restaurantDetail,
              ),
              _ => const Center(
                child: Text('Data Not Found'),
              ),
            };
          },
        ),
      ),
    );
  }
}