import 'package:bloc/bloc.dart';
import 'package:chat_application/core/base/services/auth_service.dart';
import 'package:chat_application/core/constants/hive_box.dart';
import 'package:flutter/cupertino.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthLoading()); // Emit loading state
      await Future.delayed(Duration(seconds: 2));
      if (Boxes.getUserToken().get("token")!=null) {
        emit(Authenticated(Boxes.getUserToken().get("token")));
      }else{
        emit(UnAuthecticated());
      }
    });
    on<LoginEvent>((event, emit)async{
      emit(AuthLoading());
     String? token= await AuthService().loginRequest(email: event.email, password: event.password);
     if(token!=null){
       Boxes.getUserToken().put('token', token);
       emit(Authenticated(token));
     }else{
       debugPrint('token is null');
     }
    });
    on<logoutEvent>((event, emit) async{
      emit (AuthLoading());
      await Boxes.getUserToken().delete('token');
      emit(UnAuthecticated());
    });
  }
}
