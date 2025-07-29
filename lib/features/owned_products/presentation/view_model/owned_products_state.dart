import 'package:equatable/equatable.dart';
import '../../domain/entity/owned_product_entity.dart';

sealed class OwnedProductsState extends Equatable {
  const OwnedProductsState();

  @override
  List<Object> get props => [];
}

final class OwnedProductsInitial extends OwnedProductsState {}

final class OwnedProductsLoading extends OwnedProductsState {}

final class OwnedProductsLoaded extends OwnedProductsState {
  final List<OwnedProductEntity> products;

  const OwnedProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class OwnedProductsError extends OwnedProductsState {
  final String message;

  const OwnedProductsError(this.message);

  @override
  List<Object> get props => [message];
}

final class ResellProductLoading extends OwnedProductsState {}

final class ResellProductSuccess extends OwnedProductsState {
  final String message;

  const ResellProductSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class ResellProductError extends OwnedProductsState {
  final String message;

  const ResellProductError(this.message);

  @override
  List<Object> get props => [message];
}