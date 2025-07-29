import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/permission_creator/data/data_source/transfer_request_remote_datasource.dart';
import 'package:batch34_b/features/permission_creator/domain/entity/transfer_request_entity.dart';
import 'package:batch34_b/features/permission_creator/domain/repository/transfer_request_repository.dart';
import 'package:dartz/dartz.dart';


class TransferRequestRepositoryImpl implements TransferRequestRepository {
  final TransferRequestRemoteDataSource remoteDataSource;

  TransferRequestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TransferRequestEntity>>> getIncomingTransferRequests() async {
    try {
      final transferRequests = await remoteDataSource.getIncomingTransferRequests();
      return Right(transferRequests);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> respondToTransferRequest(String productId, String action) async {
    try {
      await remoteDataSource.respondToTransferRequest(productId, action);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
