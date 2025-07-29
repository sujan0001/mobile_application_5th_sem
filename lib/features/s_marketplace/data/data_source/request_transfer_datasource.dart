import 'package:batch34_b/features/s_marketplace/data/model/request_transfer_response_model.dart';

abstract class IRequestTransferDataSource {
  /// Makes a POST request to request product transfer
  /// [productId] - The ID of the product to request transfer for
  /// Returns [RequestTransferResponseModel] with success status and message
  /// Throws [Exception] if the request fails
  Future<RequestTransferResponseModel> requestProductTransfer(String productId);
}