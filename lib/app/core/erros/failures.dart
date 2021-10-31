import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  String get message;
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
