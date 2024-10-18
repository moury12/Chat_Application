import 'package:chat_application/core/base/services/socket_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 final TextEditingController messageController=TextEditingController();
 final TextEditingController recipientController=TextEditingController();
 @override
  void initState() {
    super.initState();
    ChatService().initializeSocket();
  }
  @override
  void dispose() {
   ChatService().disconnect();
   messageController.dispose();
   recipientController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void sendMessage(){
   String message =messageController.text;
   String recipient = recipientController.text;
   ChatService().sendMessage(message, recipient);
   messageController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),),
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
