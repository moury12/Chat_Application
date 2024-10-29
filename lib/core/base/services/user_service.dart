import 'package:chat_application/core/base/models/user_model.dart';
import 'package:chat_application/core/constants/api_client.dart';
import 'package:chat_application/core/constants/hive_box.dart';
import 'package:chat_application/core/init/dio_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UserService {
  DioManager dioManager = DioManager.instance;
  Future<List<UserModel>> getAllUserData() async {
    List<UserModel> users = [];
    try {
      final response = await dioManager.dio.get(ApiClient().getAllUserUrl,
          options: Options(headers: {
            'Authorization': 'Bearer ${Boxes.getUserToken().get("token")}'
          }));
      final responseData = response.data['users'];

      users = responseData
          .map<UserModel>((val) => UserModel.fromJson(val))
          .toList();

      return users;
    } catch (e) {
      debugPrint(e.toString());
      return users;
    }
  }

  Future<UserModel> getUserInfo() async {
    UserModel user = UserModel();
    try {
      final response = await dioManager.dio.get(ApiClient().getUserUrl,
          options: Options(headers: {
            'Authorization': 'Bearer ${Boxes.getUserToken().get("token")}'
          }));
      debugPrint(response.toString());
       user =UserModel.fromJson(response.data);
      return user;
    } catch (e) {
      debugPrint(e.toString());
      return user;
    }
  }
}
