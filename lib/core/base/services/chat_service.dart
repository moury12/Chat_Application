import 'package:chat_application/core/base/models/message_model.dart';
import 'package:chat_application/core/constants/api_client.dart';
import 'package:chat_application/core/constants/hive_box.dart';
import 'package:chat_application/core/init/dio_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ChatService{
  DioManager dioManager =DioManager.instance;
  Future<List<MessageModel>> getMessages({required String user1,required String user2})async{
    List<MessageModel> messageList=[];
    try{
      final response = await dioManager.dio.get('${ApiClient().getMessageUrl}?user1=$user1&user2=$user2',
          options: Options(headers: {
            'Authorization': 'Bearer ${Boxes.getUserToken().get("token")}'
          }));
      final responseData = response.data;

      messageList = responseData
          .map<MessageModel>((val) => MessageModel.fromJson(val))
          .toList();
      return messageList;
    }catch(e){
      debugPrint(e.toString());
      return messageList;
    }
  }
}