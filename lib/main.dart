import 'package:flutter/material.dart';
import 'package:yaqiz/page/login.dart';

void main() {
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