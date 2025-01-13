import 'package:camera/camera.dart';
import 'package:everdell_frontend/pages/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

late List<CameraDescription> _cameras;

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isCameraInitialized = false;
  bool _arePermissionsGranted = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await requestStoragePermission();
    await _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      setState(() {
        _isCameraInitialized = true;
      });

      // Navigate to HomePage if everything is ready
      _navigateToHomePage();
    } catch (e) {
      if (kDebugMode) {
        print("Error initializing cameras: $e");
      }
    }
  }

  Future<void> requestStoragePermission() async {
    if (!kIsWeb) {
      // Request storage permission
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }

      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }

      if (storageStatus.isGranted && cameraStatus.isGranted) {
        setState(() {
          _arePermissionsGranted = true;
        });

        _navigateToHomePage();
      }

      if (kDebugMode) {
        print("Storage Permission: ${storageStatus.isGranted}");
        print("Camera Permission: ${cameraStatus.isGranted}");
      }
    }
  }

  void _navigateToHomePage() {
    if (true) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              title: 'Everdell',
              cameras: _cameras,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                const SizedBox(height: 20),
                if (!_isCameraInitialized || !_arePermissionsGranted)
                  const CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
