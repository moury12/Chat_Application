part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AppStarted  extends AuthEvent{

}
class LoginEvent extends AuthEvent{
final String email;
final String password;

  LoginEvent({required this.email, required this.password});

}
class logoutEvent extends AuthEvent{

}
