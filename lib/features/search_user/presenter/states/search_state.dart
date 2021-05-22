import 'package:mobile_challenge/core/usecase/errors/error.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';

abstract class SearchState {}

class StartState implements SearchState {
  const StartState();
}

class LoadingState implements SearchState {
  const LoadingState();
}

class ErrorState implements SearchState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements SearchState {
  final List<UserEntity> list;
  const SuccessState(this.list);
}
