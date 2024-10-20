import 'package:chat_application/core/base/blocs/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockProviders{
  static List allBlocProviders=[
    BlocProvider(create: (context) => AuthBloc()..add(AppStarted()),)
  ];
}