import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:everdell_frontend/config/app_config.dart';
import 'package:everdell_frontend/pages/landing_page.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;
final myTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  final isEmulator = androidInfo.isPhysicalDevice != true;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everdell',
      theme: myTheme,
      home: const LandingPage(),
    );
  }
}
