class RequestTransferResponseModel {
  final bool success;
  final String message;

  RequestTransferResponseModel({
    required this.success,
    required this.message,
  });

  factory RequestTransferResponseModel.fromJson(Map<String, dynamic> json) {
    return RequestTransferResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}