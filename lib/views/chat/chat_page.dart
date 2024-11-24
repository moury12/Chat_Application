import 'package:chat_application/core/base/blocs/chat/messaging_bloc.dart';
import 'package:chat_application/core/base/models/message_model.dart';
import 'package:chat_application/core/base/models/user_model.dart';
import 'package:chat_application/core/base/services/chat_service.dart';
import 'package:chat_application/core/base/services/socket_service.dart';
import 'package:chat_application/core/components/default_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final UserModel currentUser;
  final UserModel recipientUser;

  const ChatScreen({
    required this.currentUser,
    required this.recipientUser,
    Key? key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late SocketService socketService;
  final TextEditingController messageController = TextEditingController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();

    // Initialize SocketService
    socketService = SocketService(currentUserId: widget.currentUser.id ?? '');

    // Listen to the message stream
    socketService.messageStream.listen((newMessage) {
      setState(() {
        messages.add(newMessage);
      });
    });

    // Load initial messages
    _fetchInitialMessages();
  }

  Future<void> _fetchInitialMessages() async {
    List<MessageModel> initialMessages = await ChatService().getMessages(
      user1: widget.currentUser.id ?? '',
      user2: widget.recipientUser.id ?? '',
    );
    setState(() {
      messages = initialMessages;
    });
  }

  void _sendMessage() {
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      socketService.sendMessage(message, widget.recipientUser.id ?? '');
      setState(() {
        messages.add(
          MessageModel(
            from: widget.currentUser.id,
            to: widget.recipientUser.id,
            message: message,
            timeStamp: DateTime.now().toString(),
          ),
        );
      });
      messageController.clear();
    }
  }

  @override
  void dispose() {
    socketService.disconnect();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipientUser.email ?? 'Chat'),
      ),
      body: Column(
        children: [
          // Message List
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isCurrentUser = message.from == widget.currentUser.id;

                return Align(
                  alignment:
                  isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.from ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          message.message ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Message Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      labelText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


