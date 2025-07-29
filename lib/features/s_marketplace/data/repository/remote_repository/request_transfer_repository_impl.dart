
import 'package:batch34_b/features/s_marketplace/data/data_source/request_transfer_datasource.dart';
import 'package:batch34_b/features/s_marketplace/domain/entity/request_transfer_entity.dart';
import 'package:batch34_b/features/s_marketplace/domain/repository/request_transfer_repository.dart';

class RequestTransferRepositoryImpl implements RequestTransferRepository {
  final IRequestTransferDataSource remoteDataSource;

  RequestTransferRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<RequestTransferEntity> requestProductTransfer(String productId) async {
    try {
      final response = await remoteDataSource.requestProductTransfer(productId);
      
      return RequestTransferEntity(
        success: response.success,
        message: response.message,
      );
    } catch (e) {
      throw Exception('Repository: Failed to request product transfer - $e');
    }
  }
}