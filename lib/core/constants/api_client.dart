class ApiClient{
 late String baseUrl ="http://192.168.100.238:3000/api/";
   String get loginUrl=>"auth/login";
   String get getUserUrl=>"auth/userInfo";
   String get getAllUserUrl=>"auth/users";
   String get getMessageUrl=>"messages/getMessages";
}