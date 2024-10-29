part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoState {}

final class UserInfoLoadingState extends UserInfoState {}
final class UserInfoLoadedState extends UserInfoState {
  final UserModel userInfo;

  UserInfoLoadedState({required this.userInfo});
}
