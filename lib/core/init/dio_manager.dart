import 'package:chat_application/core/constants/api_client.dart';
import 'package:dio/dio.dart';

class DioManager{
  static DioManager? _instance;
late final Dio dio;
  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager._init();
    return _instance!;
  }
DioManager._init(){
    dio =Dio(
      BaseOptions(
        baseUrl: ApiClient().baseUrl,
        followRedirects: true
      )
    );
}


}