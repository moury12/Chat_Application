import 'package:chat_application/core/base/blocs/user/user-own/user_info_bloc.dart';
import 'package:chat_application/core/base/services/notification_service.dart';
import 'package:chat_application/core/base/services/socket_service.dart';
import 'package:chat_application/core/constants/app/color_constant.dart';
import 'package:chat_application/core/constants/bloc_providers.dart';
import 'package:chat_application/core/constants/hive_box.dart';
import 'package:chat_application/views/auth-views/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';


Future<void> initializeSocketInBackground() async {


  if (Boxes.getUserToken().isNotEmpty&&Boxes.getUserToken().get('user_id')!=null&&Boxes.getUserToken().get('user_id').isNotEmpty) {
    final userId = Boxes.getUserToken().get('user_id');

    // Initialize the socket with the fetched userId
      final socketService = SocketService(currentUserId: userId!);

  await socketService.initializeSocket();

  // Listen to incoming messages
  socketService.messageStream.listen((message) {
  print("Message received in background: ${message.message}");

  // Show notification for the new message
  NotificationService.showNotification(
  1,
  "Message from ${message.from}",
  message.message??'',
  );
  });
  } else {
    print("UserInfoBloc is not in a loaded state. Cannot fetch userId.");
  }



  // Initialize the SocketService

}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async{
    print("Native called background task: $task");
    await initializeSocketInBackground();
    //simpleTask will be emitted here.
    return Future.value(true);
  });
}
void main() async{
  await Hive.initFlutter();
  await Hive.openBox("userInfo");
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...BlockProviders.allBlocProviders],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme:ThemeData(
          listTileTheme: ListTileThemeData(textColor: ColorConstant.black)
        ) ,
        home: const AuthScreen(),
      ),
    );
  }
}

