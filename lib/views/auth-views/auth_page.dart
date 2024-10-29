import 'package:chat_application/core/base/blocs/auth/auth_bloc.dart';
import 'package:chat_application/views/auth-views/login_page.dart';
import 'package:chat_application/views/chat/chat_page.dart';
import 'package:chat_application/views/splash_page.dart';
import 'package:chat_application/views/users/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(builder: (context, state) {
      if(state is AuthInitial || state is AuthLoading){
        context.read<AuthBloc>().add(AppStarted());
        return SplashScreen();

      }
      else if(state is UnAuthecticated){
        return LoginScreen();

      }else if(state is Authenticated){
        return UserListScreen();
      }else {
        return Center(child: Text("Unexpected State"));
      }
    },);
  }
}
