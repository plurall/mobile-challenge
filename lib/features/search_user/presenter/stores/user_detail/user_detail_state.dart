import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';

abstract class UserDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class StartState extends UserDetailState {}

class LoadingState extends UserDetailState {}

class LoadedState extends UserDetailState {
  final UserDetailEntity user;

  LoadedState({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorState extends UserDetailState {
  late final String message;

  ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
