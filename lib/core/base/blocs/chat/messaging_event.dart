part of 'messaging_bloc.dart';

@immutable
sealed class MessagingEvent {}
class FetchMessageEvent extends MessagingEvent{
  final String user1;
  final String user2;

  FetchMessageEvent({required this.user1, required this.user2});
}
class NewMessageReceivedEvent extends MessagingEvent{
  final MessageModel messageModel;

  NewMessageReceivedEvent({required this.messageModel});
}
