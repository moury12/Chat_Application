part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class Authenticated extends AuthState{
  final String token;

  Authenticated(this.token);

}
class UnAuthecticated extends AuthState{

}
class AuthLoading extends AuthState{

}
