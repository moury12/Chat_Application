import 'package:chat_application/core/constants/bloc_providers.dart';
import 'package:chat_application/views/auth-views/auth_page.dart';
import 'package:chat_application/views/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox("userInfo");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...BlockProviders.allBlocProviders],
      child: const MaterialApp(
        title: 'Flutter Demo',

        home: AuthScreen(),
      ),
    );
  }
}

