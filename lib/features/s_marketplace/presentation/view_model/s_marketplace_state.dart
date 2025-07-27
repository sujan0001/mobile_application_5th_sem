import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
import 'package:equatable/equatable.dart';

class SMarketplaceState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<ProductEntity> soldProducts;
  final String? errorMessage;

  const SMarketplaceState({
    required this.isLoading,
    required this.isSuccess,
    required this.soldProducts,
    this.errorMessage,
  });

  const SMarketplaceState.initial()
      : isLoading = false,
        isSuccess = false,
        soldProducts = const [],
        errorMessage = null;

  SMarketplaceState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<ProductEntity>? soldProducts,
    String? errorMessage,
  }) {
    return SMarketplaceState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      soldProducts: soldProducts ?? this.soldProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, soldProducts, errorMessage];
}