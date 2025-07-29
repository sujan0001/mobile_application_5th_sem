import 'package:batch34_b/features/s_marketplace/domain/usecase/request_product_transfer_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'request_transfer_state.dart';

class RequestTransferCubit extends Cubit<RequestTransferState> {
  final RequestProductTransferUseCase requestProductTransferUseCase;

  RequestTransferCubit({
    required this.requestProductTransferUseCase,
  }) : super(RequestTransferInitial());

  /// Requests transfer for a specific product
  Future<void> requestProductTransfer(String productId) async {
    try {
      // Emit loading state for this specific product
      emit(RequestTransferLoading(productId: productId));

      // Execute the use case
      final result = await requestProductTransferUseCase.call(productId);

      // Emit success or failure based on the result
      if (result.success) {
        emit(RequestTransferSuccess(
          message: result.message,
          productId: productId,
        ));
      } else {
        emit(RequestTransferFailure(
          message: result.message,
          productId: productId,
        ));
      }
    } catch (e) {
      // Emit failure state with error message
      emit(RequestTransferFailure(
        message: _getErrorMessage(e),
        productId: productId,
      ));
    }
  }

  /// Reset state to initial
  void resetState() {
    emit(RequestTransferInitial());
  }

  /// Check if a specific product is currently being requested
  bool isProductLoading(String productId) {
    return state is RequestTransferLoading &&
        (state as RequestTransferLoading).productId == productId;
  }

  /// Get user-friendly error message
  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('Authentication token not found')) {
      return 'Please login to continue';
    } else if (error.toString().contains('Network error')) {
      return 'Network connection failed. Please check your internet.';
    } else if (error.toString().contains('Transfer already pending')) {
      return 'Transfer request already pending for this product';
    } else if (error.toString().contains('Product not available')) {
      return 'This product is no longer available for sale';
    } else {
      return 'Failed to send request. Please try again.';
    }
  }
}