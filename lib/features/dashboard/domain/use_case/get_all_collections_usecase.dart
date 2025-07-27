import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class GetAllCollectionsUseCase {
  final IDashboardRepository repository;

  GetAllCollectionsUseCase(this.repository);

  Future<Either<Failure, List<CollectionEntity>>> call() {
    return repository.getAllCollections();
  }
}
