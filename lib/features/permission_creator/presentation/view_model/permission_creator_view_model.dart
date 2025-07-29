import 'package:batch34_b/features/permission_creator/domain/entity/transfer_request_entity.dart';
import 'package:batch34_b/features/permission_creator/domain/use_case/et_incoming_transfer_requests.dart';
import 'package:batch34_b/features/permission_creator/domain/use_case/respond_to_transfer_request.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';


class PermissionCreatorViewModel extends ChangeNotifier {
  final GetIncomingTransferRequests _getIncomingTransferRequests;
  final RespondToTransferRequest _respondToTransferRequest;

  PermissionCreatorViewModel({
    required GetIncomingTransferRequests getIncomingTransferRequests,
    required RespondToTransferRequest respondToTransferRequest,
  })  : _getIncomingTransferRequests = getIncomingTransferRequests,
        _respondToTransferRequest = respondToTransferRequest;

  // State variables
  List<TransferRequestEntity> _requests = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<TransferRequestEntity> get requests => _requests;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get hasRequests => _requests.isNotEmpty;

  // Load transfer requests
  Future<void> loadTransferRequests() async {
    _setLoading(true);
    _clearError();

    final result = await _getIncomingTransferRequests(NoParams());

    result.fold(
      (failure) => _setError(failure.message),
      (requests) => _setRequests(requests),
    );

    _setLoading(false);
  }

  // Respond to transfer request
  Future<void> respondToRequest(String productId, String action) async {
    _setLoading(true);
    _clearError();

    final result = await _respondToTransferRequest(
      RespondToTransferRequestParams(productId: productId, action: action),
    );

    result.fold(
      (failure) => _setError(failure.message),
      (_) => loadTransferRequests(), // Reload requests after successful response
    );
  }

  // Accept transfer request
  Future<void> acceptRequest(String productId) async {
    await respondToRequest(productId, 'accept');
  }

  // Decline transfer request
  Future<void> declineRequest(String productId) async {
    await respondToRequest(productId, 'decline');
  }

  // Private methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setRequests(List<TransferRequestEntity> requests) {
    _requests = requests;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Dispose method
  @override
  void dispose() {
    super.dispose();
  }
}

