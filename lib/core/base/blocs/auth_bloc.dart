import 'package:bloc/bloc.dart';
import 'package:chat_application/core/base/services/auth_service.dart';
import 'package:chat_application/core/constants/hive_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthLoading()); // Emit loading state
      await Future.delayed(Duration(seconds: 2));
      if (Boxes.getUserData().get("token")!=null) {
        emit(Authenticated(Boxes.getUserData().get("token")));
      }else{
        emit(UnAuthecticated());
      }
    });
    on<LoginEvent>((event, emit)async{
      emit(AuthLoading());
     String? token= await AuthService().loginRequest(email: event.email, password: event.password);
     if(token!=null){
       Boxes.getUserData().put('token', token);
       emit(Authenticated(token));
     }else{
       debugPrint('token is null');
     }
    });
    on<logoutEvent>((event, emit) async{
      emit (AuthLoading());
      await Boxes.getUserData().delete('token');
      emit(UnAuthecticated());
    });
  }
}
