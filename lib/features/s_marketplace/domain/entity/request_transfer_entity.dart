class RequestTransferEntity {
  final bool success;
  final String message;

  RequestTransferEntity({
    required this.success,
    required this.message,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestTransferEntity &&
          runtimeType == other.runtimeType &&
          success == other.success &&
          message == other.message;

  @override
  int get hashCode => success.hashCode ^ message.hashCode;

  @override
  String toString() {
    return 'RequestTransferEntity{success: $success, message: $message}';
  }
}