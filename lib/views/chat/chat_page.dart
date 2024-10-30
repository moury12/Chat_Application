import 'package:chat_application/core/base/blocs/chat/messaging_bloc.dart';
import 'package:chat_application/core/base/models/user_model.dart';
import 'package:chat_application/core/base/services/socket_service.dart';
import 'package:chat_application/core/components/default_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final UserModel recipientUser;
  final UserModel currentUser;
  const ChatScreen(
      {super.key, required this.recipientUser, required this.currentUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  @override
  void initState() {
    super.initState();
    SocketService(currentUserId: widget.currentUser.id!).initializeSocket();
    // context.read<MessagingBloc>().add(FetchMessageEvent(user1: widget.recipientUser.id??'', user2: widget.currentUser.id??''));
  }

  @override
  void dispose() {
    SocketService(currentUserId: widget.currentUser.id!).disconnect();
    messageController.dispose();
    recipientController.dispose();
    super.dispose();
  }

  void sendMessage() {
    String message = messageController.text;
    String recipient = widget.recipientUser.id ?? '';
    SocketService(currentUserId: widget.currentUser.id!)
        .sendMessage(message, recipient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipientUser.email ?? ''),
      ),
      body: BlocProvider(
  create: (context) =>MessagingBloc(
     SocketService(currentUserId: widget.currentUser.id!),
  )..add(FetchMessageEvent(
    user1: widget.recipientUser.id ?? '',
    user2: widget.currentUser.id ?? '',
  )),
  child: BlocBuilder<MessagingBloc, MessagingState>(
        builder: (context, state) {
          if (state is MessagingLoadingState) {
            return const DefaultLoading();
          } else if (state is MessagingLoadedState) {

            return ListView.builder(

              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: state.messages[index].from==widget.currentUser.id?CrossAxisAlignment.start:CrossAxisAlignment.end,

                  children: [
                    Text(state.messages[index].from??''),
                    Text(state.messages[index].message??'')
                  ],
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
),
      bottomSheet: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: const InputDecoration(
                labelText: 'Message',
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  sendMessage();
                },
                child: const Text('send message')),
          )
        ],
      ),
    );
  }
}
