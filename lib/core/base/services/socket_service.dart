import 'dart:async';
import 'dart:developer';

import 'package:chat_application/core/base/models/message_model.dart';
import 'package:chat_application/core/base/services/notification_service.dart';
import 'package:chat_application/core/constants/api_client.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketService{
  final String currentUserId;
  late final StreamController<MessageModel> messageController;
  Stream<MessageModel> get messageStream => messageController.stream;
  IO.Socket? socket;

  SocketService({required this.currentUserId}){
    messageController =StreamController<MessageModel>.broadcast();
    initializeSocket();
  }


Future<void> initializeSocket()async{
  Completer<void> completer =Completer<void>();
  socket = IO.io(ApiClient().socketUrl, <String, dynamic>{
    'transports': ['websocket'],
    'forceNew': true,
    'reconnection': true,
  });

  socket!.connect();
  socket?.onConnect((data) {
    debugPrint('Socket connected: ${socket!.connected}');
    socket!.emit('register', currentUserId);
    completer.complete();
  },);
//   socket?.on('notification', (data) {
//     log('New notification: ${data['message']} from ${data['from']}');
// NotificationService.showNotification(1, 'New message from ${data['from']}',
//     data['message']);
//   },);
  socket?.on('chat message', (data) {
    final message = MessageModel(
      from: data['from'],
      to: currentUserId,
      message: data['message'],
      timeStamp: DateTime.now().toString(),
    );
    messageController.add(message);
    NotificationService.showNotification(1, 'New message from ${data['from']}',
        data['message']);
    debugPrint('New message from ${data['from']}: ${data['message']}');

  },);

  socket?.on('disconnect', (_) {
    debugPrint('Disconnected from the server');
  });
  socket!.on('connect_error', (error) {
    debugPrint('Connection Error: $error');
    if (!completer.isCompleted) {
      completer.completeError(error);  // In case of connection error
    }
  });
  return completer.future;
}
void sendMessage(String message,String recipient)async{
 // await initializeSocket();
  debugPrint('Socket connected: ${socket?.connected}');
  debugPrint('Socket : ${socket?.toString()}');
  if(socket!= null && socket!.connected){
    socket?.emit('private message',{
      'from': currentUserId,   // Sender's unique user ID
      'to': recipient,         // Recipient's unique user ID
      'message': message,
    });
    // socket?.on('notification', (data) {
    //   debugPrint('New notification: ${data['message']} from ${data['from']}');
    //   NotificationService.showNotification(1, 'New message from ${data['from']}',
    //       data['message']);
    // },);
    debugPrint('Message sent: $message');
  }else{
    debugPrint('Socket is not connected');
  }
}
void disconnect(){
  socket?.disconnect();
}
}