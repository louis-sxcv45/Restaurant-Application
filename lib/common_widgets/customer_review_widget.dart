import 'package:flutter/material.dart';
import 'package:gastro_go_app/model/data/restaurant_detail_data/restaurant_detail.dart';
import 'package:gastro_go_app/provider/restaurant_detail_provider.dart';
import 'package:gastro_go_app/provider/restaurant_review_provider.dart';
import 'package:gastro_go_app/styles_manager/font_style_manager.dart';
import 'package:gastro_go_app/styles_manager/values_manager.dart';
import 'package:provider/provider.dart';

class CustomerReviewWidget extends StatefulWidget {
  final RestaurantDetail data;

  const CustomerReviewWidget({super.key, required this.data});

  @override
  State<CustomerReviewWidget> createState() => _CustomerReviewWidgetState();
}

class _CustomerReviewWidgetState extends State<CustomerReviewWidget> {
  final _nameController = TextEditingController();
  final _customerReview = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3, // Tambahkan efek shadow untuk tampilan card
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
          border: Border.all(color: Colors.grey[300]!), // Tambahkan border halus
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Beri Ulasan",
              style: TextStyle(
                fontSize: FontSizeManager.f18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSize.s12),
            
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nama Anda",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s12),
            
            TextField(
              controller: _customerReview,
              decoration: InputDecoration(
                labelText: "Ulasan Anda",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: AppSize.s16),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty &&
                      _customerReview.text.isNotEmpty ) {
                    context.read<RestaurantReviewProvider>().addReview(
                        widget.data.id, _nameController.text, _customerReview.text);
                    _nameController.clear();
                    _customerReview.clear();
                    context.read<RestaurantDetailProvider>().getRestaurantDetail(widget.data.id);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
                child: const Text(
                  'Kirim Ulasan',
                  style: TextStyle(fontSize: FontSizeManager.f12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
