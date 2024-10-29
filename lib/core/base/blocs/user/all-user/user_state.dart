part of 'user_bloc.dart';

@immutable
sealed class UserState {}

 class UserLoadingState extends UserState {}
 class UserLoadedState extends UserState {
  final List<UserModel> users;

  UserLoadedState({required this.users});
 }
 class UserError extends UserState {
  final String errorMessage;

  UserError(this.errorMessage);

 }
