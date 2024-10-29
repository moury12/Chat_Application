part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoEvent {}
class FetchUserInfoEvent extends UserInfoEvent{

}
