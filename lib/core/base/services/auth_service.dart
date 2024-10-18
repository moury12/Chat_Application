import 'package:chat_application/core/constants/api_client.dart';
import 'package:chat_application/core/constants/hive_box.dart';
import 'package:chat_application/core/init/dio_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  late DioManager dioManager;
  Future<String?> loginRequest({
    required String email,
    required String password,
  }) async {
    String? token;
    try {
      Response response = await dioManager.dio.post(ApiClient().loginUrl,
          data: {"email": email, "password": password});
      Map<String, dynamic> responseData = response.data;
      if (responseData['status'] != null && responseData['status']) {
        debugPrint(responseData.toString());
        token = responseData['token'];
        Boxes.getUserData().put("token", token);
      } else {
        debugPrint(responseData['message']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return token;
  }
}
