part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {
  final bool isLogedIn;

  AuthInitial({required this.isLogedIn});
}
