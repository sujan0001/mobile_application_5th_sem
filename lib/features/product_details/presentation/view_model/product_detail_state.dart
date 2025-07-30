import 'package:batch34_b/features/product_details/domain/entity/product_detail_entity.dart';

abstract class ProductDetailState {}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final ProductDetailEntity product;

  ProductDetailLoadedState({required this.product});
}

class ProductDetailErrorState extends ProductDetailState {
  final String message;

  ProductDetailErrorState({required this.message});
}