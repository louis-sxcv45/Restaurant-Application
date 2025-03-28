import 'package:gastro_go_app/model/data/restaurant_detail_data/customer_review.dart';

sealed class RestaurantReviewState {}

class RestaurantReviewNoneState extends RestaurantReviewState {}

class RestaurantReviewLoadingState extends RestaurantReviewState {}

class RestaurantReviewErrorState extends RestaurantReviewState {
  final String errorMessage;

  RestaurantReviewErrorState(this.errorMessage);
}

class RestaurantReviewLoadedState extends RestaurantReviewState {
  final List<CustomerReview> data;

  RestaurantReviewLoadedState(this.data);
}
