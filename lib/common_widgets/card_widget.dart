import 'package:flutter/material.dart';
import 'package:gastro_go_app/common_widgets/favorite_icon_widget.dart';
import 'package:gastro_go_app/model/data/restaurant_list_data/restaurant_data.dart';
import 'package:gastro_go_app/model/image_api/image_api.dart';
import 'package:gastro_go_app/styles_manager/font_style_manager.dart';
import 'package:gastro_go_app/styles_manager/values_manager.dart';

class CardWidget extends StatelessWidget {
  final RestaurantData restaurantData;
  final String name;
  final String image;
  final String city;
  final double rating;
  final Function() onTap;
  const CardWidget(
      {super.key,
      required this.name,
      required this.image,
      required this.city,
      required this.rating,
      required this.restaurantData,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    String imageUrl = ImageApi.baseUrl + image;
    return SizedBox(
      width: 343,
      height: 205,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'dash_${name}_$city',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSize.s8),
                        topRight: Radius.circular(AppSize.s8),
                      ),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 124,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
    
                  Positioned(
                    top: 8,
                    right: 8,
                    child: FavoriteIconWidget(restaurantData: restaurantData),
                  )
                ],
              ),
    
              ListTile(
                title: Text(
                  name,
                  style: const TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      size: AppSize.s18,
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    Text(
                      city,
                      style: const TextStyle(
                          fontSize: AppSize.s14,
                          fontWeight: FontWeightManager.light,
                          color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                        size: AppSize.s18, Icons.star, color: Colors.yellow),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: AppSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
