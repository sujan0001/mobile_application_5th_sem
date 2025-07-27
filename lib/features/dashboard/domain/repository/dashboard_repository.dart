import 'package:dartz/dartz.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';

abstract class IDashboardRepository {
  Future<Either<Failure, List<CollectionEntity>>> getAllCollections();
  Future<Either<Failure, List<CreatorEntity>>> getAllCreators();
  Future<Either<Failure, List<ProductEntity>>> getAvailableProducts();
}
