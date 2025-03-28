import 'package:flutter/material.dart';
import 'package:gastro_go_app/styles_manager/font_style_manager.dart';
import 'package:gastro_go_app/styles_manager/values_manager.dart';

class LocationWidget extends StatelessWidget {
  final String city;
  final String address;
  final double rating;
  const LocationWidget({
    super.key,
    required this.city,
    required this.address,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: AppMargin.m8),
          child: Row(
            children: [
              const Icon(Icons.location_city_rounded),
              Text(
                city,
                style: TextStyle(
                  fontSize: AppSize.s16,
                  fontWeight: FontWeightManager.regular,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  Text(
                    rating.toString(),
                    style: TextStyle(
                      fontSize: AppSize.s16,
                      fontWeight: FontWeightManager.regular,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSize.s14),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: AppMargin.m8),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              Text(
                address,
                style: TextStyle(
                  fontSize: AppSize.s16,
                  fontWeight: FontWeightManager.regular,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
