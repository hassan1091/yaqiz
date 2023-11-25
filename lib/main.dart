import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yaqiz/alarm_info.dart';
import 'package:yaqiz/page/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmInfoAdapter());
  await Hive.openBox<AlarmInfo>('alarms');
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
      home: const LoginPage(),
    );
  }
}
