import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:everdell_frontend/widgets/camera_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.cameras});

  final String title;
  final List<CameraDescription> cameras;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CameraController controller;
  XFile? imageFile;
  bool _isCameraInitialized = false;

  Future<bool> isEmulator() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final isEmulator = androidInfo.isPhysicalDevice != true;
    return isEmulator;
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    controller = CameraController(widget.cameras[1], ResolutionPreset.max);

    try {
      await controller.initialize();
      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    } on CameraException catch (e) {
      if (e.code == 'CameraAccessDenied') {
        print("Camera access was denied.");
      } else {
        print("Error initializing camera: $e");
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Stack(children: [
        Image.asset(
          'assets/images/everdell-bg.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Take a picture of your city to calculate your score',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black, // Override text color for visibility
                    ),
              ),
              if (_isCameraInitialized)
                Container(
                    decoration: const BoxDecoration(color: Colors.black12),
                    child: CameraWidget(
                        controller: controller, imageFile: imageFile)),
            ],
          ),
        ),
      ]),
    );
  }
}
