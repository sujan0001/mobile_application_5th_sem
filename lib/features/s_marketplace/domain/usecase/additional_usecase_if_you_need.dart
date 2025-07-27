// import 'package:batch34_b/app/usecase/usecase.dart';
// import 'package:batch34_b/core/error/failure.dart';
// import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
// import 'package:batch34_b/features/s_marketplace/domain/repository/s_marketplace_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';

// // Example: Buy Product Usecase
// class BuyProductParams extends Equatable {
//   final String productId;

//   const BuyProductParams({required this.productId});

//   @override
//   List<Object?> get props => [productId];
// }

// class BuyProductUsecase implements UsecaseWithParams<ProductEntity, BuyProductParams> {
//   final ISMarketplaceRepository _sMarketplaceRepository;

//   BuyProductUsecase({
//     required ISMarketplaceRepository sMarketplaceRepository,
//   }) : _sMarketplaceRepository = sMarketplaceRepository;

//   @override
//   Future<Either<Failure, ProductEntity>> call(BuyProductParams params) async {
//     final result = await _sMarketplaceRepository.buyProduct(params.productId);
//     return result.fold(
//       (failure) => Left(failure),
//       (product) => Right(product),
//     );
//   }
// }

// // Example: List Product for Resale Usecase
// class ListProductForResaleParams extends Equatable {
//   final String productId;
//   final double price;

//   const ListProductForResaleParams({
//     required this.productId,
//     required this.price,
//   });

//   @override
//   List<Object?> get props => [productId, price];
// }

// class ListProductForResaleUsecase implements UsecaseWithParams<ProductEntity, ListProductForResaleParams> {
//   final ISMarketplaceRepository _sMarketplaceRepository;

//   ListProductForResaleUsecase({
//     required ISMarketplaceRepository sMarketplaceRepository,
//   }) : _sMarketplaceRepository = sMarketplaceRepository;

//   @override
//   Future<Either<Failure, ProductEntity>> call(ListProductForResaleParams params) async {
//     final result = await _sMarketplaceRepository.listProductForResale(
//       params.productId,
//       params.price,
//     );
//     return result.fold(
//       (failure) => Left(failure),
//       (product) => Right(product),
//     );
//   }
// }

// // Example: Search Products Usecase
// class SearchProductsParams extends Equatable {
//   final String query;

//   const SearchProductsParams({required this.query});

//   @override
//   List<Object?> get props => [query];
// }

// class SearchProductsUsecase implements UsecaseWithParams<List<ProductEntity>, SearchProductsParams> {
//   final ISMarketplaceRepository _sMarketplaceRepository;

//   SearchProductsUsecase({
//     required ISMarketplaceRepository sMarketplaceRepository,
//   }) : _sMarketplaceRepository = sMarketplaceRepository;

//   @override
//   Future<Either<Failure, List<ProductEntity>>> call(SearchProductsParams params) async {
//     final result = await _sMarketplaceRepository.searchProducts(params.query);
//     return result.fold(
//       (failure) => Left(failure),
//       (products) => Right(products),
//     );
//   }
// }

// // Example: Get Product Details Usecase
// class GetProductDetailsParams extends Equatable {
//   final String productId;

//   const GetProductDetailsParams({required this.productId});

//   @override
//   List<Object?> get props => [productId];
// }

// class GetProductDetailsUsecase implements UsecaseWithParams<ProductEntity, GetProductDetailsParams> {
//   final ISMarketplaceRepository _sMarketplaceRepository;

//   GetProductDetailsUsecase({
//     required ISMarketplaceRepository sMarketplaceRepository,
//   }) : _sMarketplaceRepository = sMarketplaceRepository;

//   @override
//   Future<Either<Failure, ProductEntity>> call(GetProductDetailsParams params) async {
//     final result = await _sMarketplaceRepository.getProductDetails(params.productId);
//     return result.fold(
//       (failure) => Left(failure),
//       (product) => Right(product),
//     );
//   }
// }