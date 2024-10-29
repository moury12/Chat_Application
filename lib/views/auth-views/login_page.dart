import 'package:chat_application/core/base/blocs/auth/auth_bloc.dart';
import 'package:chat_application/core/components/button/custom_button.dart';
import 'package:chat_application/core/components/text-field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          CustomTextField(hintText: 'Enter Email',controller: emailController,),
          CustomTextField(hintText: 'Enter password',controller: passController,),
             CustomButton(title: 'Login',
             onPressed: () {
               BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: emailController.text, password: passController.text));
             },)
              ],),
        ),
      ),);
  }
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}


