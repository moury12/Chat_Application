import 'package:chat_application/core/base/blocs/auth/auth_bloc.dart';
import 'package:chat_application/core/base/blocs/chat/messaging_bloc.dart';
import 'package:chat_application/core/base/blocs/user/all-user/user_bloc.dart';
import 'package:chat_application/core/base/blocs/user/user-own/user_info_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockProviders {
  static List allBlocProviders = [
    BlocProvider(
      create: (context) => AuthBloc()..add(AppStarted()),
    ),
    BlocProvider(create: (context) => UserBloc()),
    BlocProvider(create: (context) => UserInfoBloc()),
     // BlocProvider(create: (context) => MessagingBloc()),
  ];
}
