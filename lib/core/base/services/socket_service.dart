import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;


class ChatService{
  IO.Socket? socket;
String currentUserID ='user1';
Future<void> initializeSocket()async{
  Completer<void> completer =Completer<void>();
  socket = IO.io('http://192.168.0.108:3000', <String, dynamic>{
    'transports': ['websocket'],

    'forceNew': true,             // Forces a new connection
    'reconnection': true,
  });

  socket!.connect();
  socket?.onConnect((data) {
    print('Socket connected: ${socket!.connected}');
    socket!.emit('register', currentUserID);
    completer.complete();
  },);
  // socket!.on('connect', (_) {
  //   print('Connected to the server');
  //   socket!.emit('register', currentUserID);
  // });
  socket?.on('disconnect', (_) {
    print('Disconnected from the server');
  });
  socket!.on('connect_error', (error) {
    print('Connection Error: $error');
    if (!completer.isCompleted) {
      completer.completeError(error);  // In case of connection error
    }
  });
  socket?.on('chat message', (data) {
    print('New message from ${data['from']}: ${data['message']}');

  },);
  return completer.future;
}
void sendMessage(String message,String recipient)async{
 await initializeSocket();
  print('Socket connected: ${socket?.connected}');
  print('Socket : ${socket?.toString()}');
  if(socket!= null && socket!.connected){
    socket?.emit('private message',{
      'from': currentUserID,   // Sender's unique user ID
      'to': recipient,         // Recipient's unique user ID
      'message': message,
    });
    print('Message sent: $message');
  }else{
    print('Socket is not connected');
  }
}
void disconnect(){
  socket?.disconnect();
}
}