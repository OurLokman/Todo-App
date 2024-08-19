import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/main_screen.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: MainScreen(),
    );
  }
}
