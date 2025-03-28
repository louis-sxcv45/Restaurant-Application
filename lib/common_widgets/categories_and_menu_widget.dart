import 'package:flutter/material.dart';
import 'package:gastro_go_app/styles_manager/font_style_manager.dart';
import 'package:gastro_go_app/styles_manager/values_manager.dart';

class CategoriesAndMenuWidget extends StatelessWidget {
  final List categories;
  final List foodsMenu;
  final List drinksMenu;
  const CategoriesAndMenuWidget({
    super.key,
    required this.categories,
    required this.drinksMenu,
    required this.foodsMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppMargin.m8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Categories",
            style: TextStyle(
              fontSize: FontSizeManager.f18,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Wrap(
            spacing: AppSize.s8,
            children:
                categories.map((item) => Chip(label: Text(item.name))).toList(),
          ),
          const SizedBox(height: AppSize.s12),
          const Text(
            "Makanan",
            style: TextStyle(
              fontSize: FontSizeManager.f18,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Wrap(
            spacing: AppSize.s8,
            children:
                foodsMenu.map((item) => Chip(label: Text(item.name))).toList(),
          ),
          const SizedBox(height: AppSize.s12),
          const Text(
            "Minuman",
            style: TextStyle(
              fontSize: FontSizeManager.f18,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Wrap(
            spacing: AppSize.s8,
            children:
                drinksMenu.map((item) => Chip(label: Text(item.name))).toList(),
          ),
          const SizedBox(height: AppSize.s12),
        ],
      ),
    );
  }
}
