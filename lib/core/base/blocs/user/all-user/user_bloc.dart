import 'package:bloc/bloc.dart';
import 'package:chat_application/core/base/models/user_model.dart';
import 'package:chat_application/core/base/services/user_service.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingState()) {
    on<FetchUsersEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        List<UserModel> users = await UserService().getAllUserData();
        emit(UserLoadedState(users: users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
