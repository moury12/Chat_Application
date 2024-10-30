part of 'messaging_bloc.dart';

@immutable
sealed class MessagingState {}

final class MessagingLoadingState extends MessagingState {}
final class MessagingLoadedState extends MessagingState {
  final List<MessageModel> messages;

  MessagingLoadedState({required this.messages});

}
