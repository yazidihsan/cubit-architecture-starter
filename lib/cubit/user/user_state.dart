part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final List<UserModel> users;
  final String? message;

  const UserSuccess({required this.users, this.message});
  @override
  List<Object> get props => [users, message ?? ''];
}

final class UserCreated extends UserState {
  final UserModel user;
  final String? message;

  const UserCreated({required this.user, this.message});
  @override
  List<Object> get props => [user, message ?? ''];
}

final class UserUpdated extends UserState {
  final UserModel user;
  final String? message;

  const UserUpdated({required this.user, this.message});
  @override
  List<Object> get props => [user, message ?? ''];
}

class UserDeleted extends UserState {
  final String message;

  const UserDeleted({required this.message});

  @override
  List<Object> get props => [message];
}

final class UserFailed extends UserState {
  final String message;

  const UserFailed({required this.message});

  @override
  List<Object> get props => [message];
}
