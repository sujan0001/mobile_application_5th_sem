import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/core/usecases/usecase.dart';
import 'package:batch34_b/features/permission_creator/domain/repository/transfer_request_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


class RespondToTransferRequest implements UseCase<void, RespondToTransferRequestParams> {
  final TransferRequestRepository repository;

  RespondToTransferRequest({required this.repository});

  @override
  Future<Either<Failure, void>> call(RespondToTransferRequestParams params) async {
    return await repository.respondToTransferRequest(params.productId, params.action);
  }
}

class RespondToTransferRequestParams extends Equatable {
  final String productId;
  final String action;

  const RespondToTransferRequestParams({
    required this.productId,
    required this.action,
  });

  @override
  List<Object> get props => [productId, action];
}
