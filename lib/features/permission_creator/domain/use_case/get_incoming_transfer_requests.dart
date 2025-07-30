import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/core/usecases/usecase.dart';
import 'package:batch34_b/features/permission_creator/domain/entity/transfer_request_entity.dart';
import 'package:batch34_b/features/permission_creator/domain/repository/transfer_request_repository.dart';
import 'package:dartz/dartz.dart';


// class GetIncomingTransferRequests implements UseCase<List<TransferRequestEntity>, NoParams> {
//   final TransferRequestRepository repository;

//   GetIncomingTransferRequests({required this.repository});

//   @override
//   Future<Either<Failure, List<TransferRequestEntity>>> call(NoParams params) async {
//     return await repository.getIncomingTransferRequests();
//   }
// }
class GetIncomingTransferRequests implements UseCase<List<TransferRequestEntity>, NoParams> {
  final TransferRequestRepository repository;

  GetIncomingTransferRequests({required this.repository});

  @override
  Future<Either<Failure, List<TransferRequestEntity>>> call(NoParams params) async {
    return await repository.getIncomingTransferRequests();
  }
}