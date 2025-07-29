

import 'package:batch34_b/features/permission_creator/data/model/transfer_request_model.dart';

abstract class TransferRequestRemoteDataSource {
  Future<List<TransferRequestModel>> getIncomingTransferRequests();
  Future<void> respondToTransferRequest(String productId, String action);
}
