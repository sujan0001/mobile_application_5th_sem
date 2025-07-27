import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:batch34_b/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class GetAllCreatorsUseCase {
  final IDashboardRepository repository;

  GetAllCreatorsUseCase(this.repository);

  Future<Either<Failure, List<CreatorEntity>>> call() {
    return repository.getAllCreators();
  }
}
