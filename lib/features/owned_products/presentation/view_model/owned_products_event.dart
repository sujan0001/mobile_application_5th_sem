import 'package:equatable/equatable.dart';

sealed class OwnedProductsEvent extends Equatable {
  const OwnedProductsEvent();

  @override
  List<Object> get props => [];
}

final class GetMyOwnedProductsEvent extends OwnedProductsEvent {}

final class ResellProductEvent extends OwnedProductsEvent {
  final String productId;
  final double resalePrice;

  const ResellProductEvent({
    required this.productId,
    required this.resalePrice,
  });

  @override
  List<Object> get props => [productId, resalePrice];
}
