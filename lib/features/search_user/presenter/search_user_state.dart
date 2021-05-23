import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';

abstract class SearchUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class StartState extends SearchUserState {}

class EmptyState extends SearchUserState {}

class LoadingState extends SearchUserState {}

class LoadedState extends SearchUserState {
  final List<UserEntity> users;

  LoadedState({required this.users});

  @override
  List<Object> get props => [users];
}

class ErrorState extends SearchUserState {
  late final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
