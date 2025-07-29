import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/permission_creator/domain/entity/transfer_request_entity.dart';
import 'package:dartz/dartz.dart';


abstract class TransferRequestRepository {
  Future<Either<Failure, List<TransferRequestEntity>>> getIncomingTransferRequests();
  Future<Either<Failure, void>> respondToTransferRequest(String productId, String action);
}