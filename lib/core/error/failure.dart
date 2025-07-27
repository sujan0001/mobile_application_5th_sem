
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

class RemoteDatabaseFailure extends Failure {
  final int? statusCode;
  const RemoteDatabaseFailure({this.statusCode, required super.message});
}

class SharedPreferencesFailure extends Failure {
  const SharedPreferencesFailure({required super.message});
}
// added for the failure response to the dashboard_remote_repository_impl
class ServerFailure extends RemoteDatabaseFailure {
  const ServerFailure({int? statusCode, required String message})
      : super(statusCode: statusCode, message: message);
}