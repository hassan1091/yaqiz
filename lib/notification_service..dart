import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService({required this.flutterLocalNotificationsPlugin});

  Future<void> initialize() async {
    // Initialization settings for Android devices
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialization settings for iOS devices
    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false);

    // Initialization settings for both platforms
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: darwinInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails('yaqiz', 'priority',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true);

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
        sound: 'notification_sound.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationsPlugin.show(
        1, title, body, notificationDetails);
  }

  void handleNotificationTap() {
    flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails()
        .then((details) {});
  }
}
