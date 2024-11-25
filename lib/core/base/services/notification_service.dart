import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap (if needed)
      },
    );
  }

  static Future<void> showNotification(
      int id,
      String title,
      String body,
      ) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'main_channel', // ID of the channel
      'Main Channel', // Name of the channel
      importance: Importance.high,
      priority: Priority.high,

    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notificationsPlugin.show(id, title, body, notificationDetails);
  }
}
