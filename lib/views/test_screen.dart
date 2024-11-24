import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  void connect(String userId) {
    socket = IO.io('http://localhost:3000', {
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect the socket
    socket.connect();

    // Listen for connection
    socket.on('connect', (_) {
      print('Connected to the server');
      socket.emit('register', userId); // Register user on the server
    });

    // Handle private messages
    socket.on('chat message', (data) {
      print('New message from ${data['from']}: ${data['message']}');
    });

    // Handle disconnection
    socket.on('disconnect', (_) {
      print('Disconnected from server');
    });
  }

  void sendMessage(String from, String to, String message) {
    socket.emit('private message', {
      'from': from,
      'to': to,
      'message': message,
    });
  }
}

class TestChatScreen extends StatefulWidget {
  @override
  _TestChatScreenState createState() => _TestChatScreenState();
}

class _TestChatScreenState extends State<TestChatScreen> {
  final SocketService socketService = SocketService();
  final TextEditingController messageController = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    socketService.connect('user123'); // Replace with the current user ID
    socketService.socket.on('chat message', (data) {
      setState(() {
        messages.add({'from': data['from'], 'message': data['message']});
      });
    });
  }

  @override
  void dispose() {
    socketService.socket.dispose();
    super.dispose();
  }

  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isNotEmpty) {
      socketService.sendMessage('user123', 'user456', message); // Replace with actual IDs
      setState(() {
        messages.add({'from': 'Me', 'message': message});
      });
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text('${message['from']}: ${message['message']}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
