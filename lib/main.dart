import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yaqiz/alarm_info.dart';
import 'package:yaqiz/notification_service..dart';
import 'package:yaqiz/page/home.dart';
import 'package:yaqiz/page/login.dart';
import 'package:yaqiz/shared_preferences.dart';
final notificationService = NotificationService(
  flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmInfoAdapter());
  await Hive.openBox<AlarmInfo>('alarms');
  //
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'yaqiz',
      theme: ThemeData(
        primaryColor: const Color(0xff24bec9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff24bec9)),
      ),
      home: FutureBuilder(
          future: Future.wait([
            AppLocalStorage.isExist(AppStorageKey.id),
            AppLocalStorage.getBool(AppStorageKey.supervisor)
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data![0]!) {
              return HomePage(isSupervisor: snapshot.data![1]!);
            }
            return const LoginPage();
          }),
    );
  }
}
