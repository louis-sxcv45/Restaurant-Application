import 'package:flutter/material.dart';
import 'package:gastro_go_app/common_widgets/categories_and_menu_widget.dart';
import 'package:gastro_go_app/common_widgets/customer_review_widget.dart';
import 'package:gastro_go_app/common_widgets/location_widget.dart';
import 'package:gastro_go_app/model/data/restaurant_detail_data/restaurant_detail.dart';
import 'package:gastro_go_app/model/image_api/image_api.dart';
import 'package:gastro_go_app/provider/restaurant_review_provider.dart';
import 'package:gastro_go_app/styles_manager/font_style_manager.dart';
import 'package:gastro_go_app/styles_manager/values_manager.dart';
import 'package:provider/provider.dart';

class DetailScreenWidget extends StatelessWidget {
  final RestaurantDetail data;

  const DetailScreenWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    String imageUrl = ImageApi.baseUrl + data.pictureId;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'dash_${data.id}',
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(AppSize.s8),
                bottomRight: Radius.circular(AppSize.s8),
              ),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: AppMargin.m8),
            child: Text(
              data.name,
              style: const TextStyle(
                fontSize: FontSizeManager.f24,
                fontWeight: FontWeightManager.semiBold,
              ),
            ),
          ),
          LocationWidget(
            city: data.city,
            address: data.address,
            rating: data.rating,
          ),
          const SizedBox(height: AppSize.s12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
            child: Text(
              data.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: FontSizeManager.f14,
                fontWeight: FontWeightManager.light,
              ),
            ),
          ),
          const SizedBox(height: AppSize.s12),

          CategoriesAndMenuWidget(
            categories: data.categories,
            drinksMenu: data.menus.drinks,
            foodsMenu: data.menus.foods,
          ),

          Container(
            margin: const EdgeInsets.only(left: AppMargin.m8),
            child: const Text(
              'Reviews from Customer',
              style: TextStyle(
                fontSize: FontSizeManager.f18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),

          Consumer<RestaurantReviewProvider>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    data.customerReviews.map((reviews) {
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: AppMargin.m8,
                          left: AppMargin.m8,
                        ), // Biar ada jarak antar review
                        padding: const EdgeInsets.all(AppPadding.p8),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 126, 99, 99),
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.id),

                            Text(
                              reviews.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: AppSize.s12),
                            Text(reviews.review),
                          ],
                        ),
                      );
                    }).toList(),
              );
            },
          ),
          CustomerReviewWidget(data: data),
        ],
      ),
    );
  }
}
