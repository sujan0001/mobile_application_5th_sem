import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
import 'package:batch34_b/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class GetAvailableProductsUseCase {
  final IDashboardRepository repository;

  GetAvailableProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() {
    return repository.getAvailableProducts();
  }
}
