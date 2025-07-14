import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zypeme/pages/progress_bar.dart';

class FaceScannerPage extends StatefulWidget {
  const FaceScannerPage({super.key});

  @override
  State<FaceScannerPage> createState() => _FaceScannerPageState();
}

class _FaceScannerPageState extends State<FaceScannerPage> {
  DateTime? _lastScanTime;
  late CameraController _cameraController;
  bool _isCameraInitialized = false;
  bool _faceDetected = false;
  bool _isProcessing = false;

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  InputImageRotation _rotationFromCameraSensor(int sensorOrientation) {
    switch (sensorOrientation) {
      case 0:
        return InputImageRotation.rotation0deg;
      case 90:
        return InputImageRotation.rotation90deg;
      case 180:
        return InputImageRotation.rotation180deg;
      case 270:
        return InputImageRotation.rotation270deg;
      default:
        return InputImageRotation.rotation0deg;
    }
  }

  Future<void> _initCamera() async {
    await Permission.camera.request();
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
    );
    _cameraController = CameraController(
      frontCamera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await _cameraController.initialize();
    setState(() => _isCameraInitialized = true);
    _cameraController.startImageStream(_processImage);
    Future.delayed(const Duration(seconds: 10), () {
      if (!_faceDetected && mounted) {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text("Face Not Detected"),
                content: const Text(
                  "Make sure your face is well-lit and clearly visible.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Retry"),
                  ),
                ],
              ),
        );
      }
    });
  }

  Future<void> _processImage(CameraImage image) async {
    if (_isProcessing) return;
    // Estimate brightness from the first plane (Y channel)

    if (_lastScanTime != null &&
        DateTime.now().difference(_lastScanTime!) < Duration(seconds: 1)) {
      return;
    }
    _lastScanTime = DateTime.now();

    final brightness =
        image.planes[0].bytes.fold<int>(0, (p, c) => p + c) ~/
        image.planes[0].bytes.length;
    if (brightness < 50) {
      debugPrint("Too dark for face detection.");
      _isProcessing = false;
      return;
    }

    _isProcessing = true;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (var plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: _rotationFromCameraSensor(
            _cameraController.description.sensorOrientation,
          ),

          format: InputImageFormat.nv21,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final List<Face> faces = await _faceDetector.processImage(inputImage);

      if (faces.isNotEmpty && !_faceDetected) {
        setState(() => _faceDetected = true);
        await Future.delayed(const Duration(milliseconds: 1000));

        if (!mounted) return;

        await _cameraController.stopImageStream();
        final XFile file = await _cameraController.takePicture();
        final imageBytes = await file.readAsBytes();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SuccessPage(imageBytes: imageBytes),
          ),
        );
      } else if (faces.isEmpty && mounted) {
        setState(() => _faceDetected = false);
      }
    } catch (e) {
      debugPrint("Error during face detection: $e");
    }

    _isProcessing = false;
  }

  @override
  void dispose() {
    if (mounted) {
      _cameraController.dispose();
      _faceDetector.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isCameraInitialized
              ? Stack(
                fit: StackFit.expand,
                children: [
                  CameraPreview(_cameraController),
                  CustomPaint(
                    painter: FaceCutoutPainter(faceDetected: _faceDetected),
                    child: Container(),
                  ),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}

class FaceCutoutPainter extends CustomPainter {
  final bool faceDetected;

  FaceCutoutPainter({required this.faceDetected});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = size.width / 300;

    // === 1. Create Face Cutout Path ===
    final cutoutPath = Path();
    cutoutPath.moveTo(centerX, centerY - 150 * scale);
    cutoutPath.lineTo(centerX - 70 * scale, centerY - 130 * scale);
    cutoutPath.lineTo(centerX - 90 * scale, centerY - 60 * scale);
    cutoutPath.lineTo(centerX - 85 * scale, centerY + 60 * scale);
    cutoutPath.lineTo(centerX - 40 * scale, centerY + 140 * scale);
    cutoutPath.lineTo(centerX, centerY + 160 * scale);
    cutoutPath.lineTo(centerX + 40 * scale, centerY + 140 * scale);
    cutoutPath.lineTo(centerX + 85 * scale, centerY + 60 * scale);
    cutoutPath.lineTo(centerX + 90 * scale, centerY - 60 * scale);
    cutoutPath.lineTo(centerX + 70 * scale, centerY - 130 * scale);
    cutoutPath.close();

    // === 2. White semi-transparent overlay outside the cutout ===
    final fullScreenPath =
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final maskPath = Path.combine(
      PathOperation.difference,
      fullScreenPath,
      cutoutPath,
    );

    final maskPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.9) // ← White transparent mask
          ..style = PaintingStyle.fill;

    canvas.drawPath(maskPath, maskPaint);

    // === 3. Cutout Border ===
    final borderPaint =
        Paint()
          ..color = faceDetected ? Colors.green : Colors.pinkAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    canvas.drawPath(cutoutPath, borderPaint);

    // === 4. Optional: white guide box (if needed) ===
    final rectPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: 240 * scale,
        height: 320 * scale,
      ),
      rectPaint,
    );
  }

  @override
  bool shouldRepaint(covariant FaceCutoutPainter oldDelegate) {
    return oldDelegate.faceDetected != faceDetected;
  }
}

class SuccessPage extends StatefulWidget {
  final Uint8List imageBytes;

  const SuccessPage({super.key, required this.imageBytes});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  int currentPage = 10;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.04),
                child: ProgressBar(currentPage: currentPage, totalPages: 10),
              ),
              SizedBox(height: h * 0.15),
              Container(
                width: w * 0.9,
                height: h * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.05),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: w * 0.015,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        SizedBox(height: h * 0.2),
                        CircleAvatar(
                          radius: w * 0.22,
                          backgroundImage: MemoryImage(widget.imageBytes),
                        ),
                        Positioned(
                          right: w * 0.01,
                          top: h * 0.02,
                          child: Container(
                            width: w * 0.09,
                            height: w * 0.09,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(w * 0.01),
                              child: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Twitter_Verified_Badge.svg/2048px-Twitter_Verified_Badge.svg.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.04),
                    Text(
                      "Waiting to get verified by admin",
                      style: TextStyle(fontSize: w * 0.045),
                    ),
                    SizedBox(height: h * 0.07),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FaceScannerPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(w * 0.3, h * 0.06),
                            backgroundColor: const Color(0xFFFFB3F0),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(w * 0.05),
                            ),
                          ),
                          child: const Text("Retake"),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            // TODO: Proceed button action
                          },
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(w * 0.3, h * 0.06),
                            side: const BorderSide(color: Colors.black12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(w * 0.05),
                            ),
                          ),
                          child: const Text("Proceed"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
