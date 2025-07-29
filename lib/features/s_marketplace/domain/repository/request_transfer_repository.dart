

import 'package:batch34_b/features/s_marketplace/domain/entity/request_transfer_entity.dart';

abstract class RequestTransferRepository {
  /// Requests transfer of a product from the secondary marketplace
  /// [productId] - The ID of the product to request transfer for
  /// Returns [RequestTransferEntity] with success status and message
  /// Throws [Exception] if the operation fails
  Future<RequestTransferEntity> requestProductTransfer(String productId);
}