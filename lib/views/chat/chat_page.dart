import 'package:chat_application/core/base/models/user_model.dart';
import 'package:chat_application/core/base/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 final TextEditingController messageController=TextEditingController();
 final TextEditingController recipientController=TextEditingController();
 @override
  void initState() {
    super.initState();
    ChatService(currentUserId: ).initializeSocket();
  }
  @override
  void dispose() {
   ChatService(currentUserId: ).disconnect();
   messageController.dispose();
   recipientController.dispose();
    super.dispose();
  }
  void sendMessage(){
   String message =messageController.text;
   String recipient = recipientController.text;
   ChatService(currentUserId: ).sendMessage(message, recipient);
   messageController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user.email??''),),
      body:Column(children: [
        TextField(
          controller: recipientController,
          decoration: InputDecoration(
            labelText: 'Recipient Username',
          ),
        ),TextField(
          controller: messageController,
          decoration: InputDecoration(
            labelText: 'Message',
          ),
        ),
        ElevatedButton(onPressed: () {
          sendMessage();
        }, child:Text('send message'))
      ],),
    );
  }
}
