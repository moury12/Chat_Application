import 'package:bloc/bloc.dart';
import 'package:chat_application/core/base/models/user_model.dart';
import 'package:chat_application/core/base/services/user_service.dart';
import 'package:meta/meta.dart';
part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc() : super(UserInfoLoadingState()) {
    on<FetchUserInfoEvent>((event, emit) async{
      emit(UserInfoLoadingState());
      UserModel user = await UserService().getUserInfo();
      emit(UserInfoLoadedState(userInfo: user));
    });
  }
}
