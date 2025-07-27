import 'package:equatable/equatable.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final List<CollectionEntity> collections;
  final List<ProductEntity> products;
  final List<CreatorEntity> creators;

  const DashboardState({
    required this.isLoading,
    required this.collections,
    required this.products,
    required this.creators,
  });

  const DashboardState.initial()
      : isLoading = false,
        collections = const [],
        products = const [],
        creators = const [];

  DashboardState copyWith({
    bool? isLoading,
    List<CollectionEntity>? collections,
    List<ProductEntity>? products,
    List<CreatorEntity>? creators,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      collections: collections ?? this.collections,
      products: products ?? this.products,
      creators: creators ?? this.creators,
    );
  }

  @override
  List<Object?> get props => [isLoading, collections, products, creators];
}
