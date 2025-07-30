abstract class ProductDetailEvent {}

class LoadProductDetailEvent extends ProductDetailEvent {
  final String productId;

  LoadProductDetailEvent({required this.productId});
}
