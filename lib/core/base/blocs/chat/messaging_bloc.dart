import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_application/core/base/models/message_model.dart';
import 'package:chat_application/core/base/services/chat_service.dart';
import 'package:chat_application/core/base/services/socket_service.dart';
import 'package:meta/meta.dart';


part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  final SocketService chatService;
  late StreamSubscription<MessageModel> messageSubscription;
  MessagingBloc(this.chatService) : super(MessagingLoadingState()) {
    on<FetchMessageEvent>((event, emit) async {
      emit(MessagingLoadingState());
      List<MessageModel> messages = await ChatService()
          .getMessages(user1: event.user1, user2: event.user2);
      emit(MessagingLoadedState(messages: messages));
      messageSubscription =chatService.messageStream.listen((event) {
        add(NewMessageReceivedEvent(messageModel: event));
      },);
    });
    on<NewMessageReceivedEvent>((event,emit){
      if(state is MessagingLoadedState){
        final currentState = state as MessagingLoadedState;
        final updatedMessage = List<MessageModel>.from(currentState.messages)..add(event.messageModel);
        emit(MessagingLoadedState(messages: updatedMessage));
      }
    });
  }
}
