import 'package:batch34_b/app/usecase/usecase.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
import 'package:batch34_b/features/s_marketplace/domain/repository/s_marketplace_repository.dart';
import 'package:dartz/dartz.dart';

class GetSoldProductsUsecase implements UsecaseWithoutParams<SoldProductsResponseEntity> {
  final ISMarketplaceRepository _sMarketplaceRepository;

  GetSoldProductsUsecase({
    required ISMarketplaceRepository sMarketplaceRepository,
  }) : _sMarketplaceRepository = sMarketplaceRepository;

  @override
  Future<Either<Failure, SoldProductsResponseEntity>> call() async {
    final result = await _sMarketplaceRepository.getSoldProducts();
    return result.fold(
      (failure) => Left(failure),
      (soldProductsResponse) => Right(soldProductsResponse),
    );
  }
}