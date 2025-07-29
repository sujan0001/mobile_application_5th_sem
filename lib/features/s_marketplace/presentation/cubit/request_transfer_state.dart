import 'package:equatable/equatable.dart';

abstract class RequestTransferState extends Equatable {
  const RequestTransferState();

  @override
  List<Object?> get props => [];
}

class RequestTransferInitial extends RequestTransferState {}

class RequestTransferLoading extends RequestTransferState {
  final String productId;

  const RequestTransferLoading({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class RequestTransferSuccess extends RequestTransferState {
  final String message;
  final String productId;

  const RequestTransferSuccess({
    required this.message,
    required this.productId,
  });

  @override
  List<Object?> get props => [message, productId];
}

class RequestTransferFailure extends RequestTransferState {
  final String message;
  final String productId;

  const RequestTransferFailure({
    required this.message,
    required this.productId,
  });

  @override
  List<Object?> get props => [message, productId];
}