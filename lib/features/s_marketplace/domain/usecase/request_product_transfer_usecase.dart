

import 'package:batch34_b/features/s_marketplace/domain/entity/request_transfer_entity.dart';
import 'package:batch34_b/features/s_marketplace/domain/repository/request_transfer_repository.dart';

class RequestProductTransferUseCase {
  final RequestTransferRepository repository;

  RequestProductTransferUseCase({
    required this.repository,
  });

  /// Executes the request product transfer use case
  /// [productId] - The ID of the product to request transfer for
  /// Returns [RequestTransferEntity] with operation result
  /// Throws [Exception] if the use case fails
  Future<RequestTransferEntity> call(String productId) async {
    try {
      // Validate input
      if (productId.isEmpty) {
        throw Exception('Product ID cannot be empty');
      }

      // Execute the use case
      return await repository.requestProductTransfer(productId);
    } catch (e) {
      throw Exception('UseCase: Failed to request product transfer - $e');
    }
  }

  /// Alternative method name for clarity (optional)
  Future<RequestTransferEntity> execute(String productId) async {
    return await call(productId);
  }
}