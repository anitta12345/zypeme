import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:zypeme/pages/prompt.dart';
// <-- create this file

class CustomCropScreen extends StatefulWidget {
  final Uint8List imageBytes;
  final void Function(File croppedFile, String? prompt) onCropped;

  const CustomCropScreen({
    Key? key,
    required this.imageBytes,
    required this.onCropped,
  }) : super(key: key);

  @override
  State<CustomCropScreen> createState() => _CustomCropScreenState();
}

class _CustomCropScreenState extends State<CustomCropScreen> {
  final CropController _cropController = CropController();
  String? _selectedPrompt;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cropController.aspectRatio = 2 / 4; // Safe now
    }); // Set 3:4 aspect ratio here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Top bar with cancel & confirm
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 28),
                    ),
                    GestureDetector(
                      onTap: () => _cropController.crop(),
                      child: const Icon(Icons.check, size: 28),
                    ),
                  ],
                ),
              ),

              // Crop area with 3:2 aspect ratio
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: AspectRatio(
                  aspectRatio: 4 / 4,
                  child: // Inside your CustomCropScreen's build()
                      Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: AspectRatio(
                      aspectRatio: 2 / 4, // switch to 3:2
                      child: Stack(
                        children: [
                          Crop(
                            controller: _cropController,
                            image: widget.imageBytes,
                            onCropped: (Uint8List croppedData) async {
                              final tempDir = Directory.systemTemp;
                              final croppedFile = await File(
                                '${tempDir.path}/cropped_image_${DateTime.now().millisecondsSinceEpoch}.png',
                              ).writeAsBytes(croppedData);

                              Navigator.pop(context, {
                                'file': croppedFile,
                                'prompt': _selectedPrompt,
                              });
                            },
                            baseColor: Colors.white,
                            maskColor: const Color.fromARGB(
                              255,
                              248,
                              247,
                              247,
                            ).withOpacity(0.3),
                            cornerDotBuilder:
                                (size, edgeAlignment) => const DotControl(
                                  color: Color.fromARGB(255, 251, 249, 249),
                                ),
                            withCircleUi: false,
                            fixArea: true,
                            interactive: true,
                          ),

                          Positioned.fill(
                            child: IgnorePointer(
                              child: CustomPaint(painter: _GridPainter()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 0),

              // Prompt Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push<String?>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PromptSelectionScreen(),
                      ),
                    );
                    if (result != null) {
                      setState(() {
                        _selectedPrompt = result;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _selectedPrompt ?? "Add prompt for your image",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color.fromARGB(255, 96, 95, 95).withOpacity(0.7)
          ..strokeWidth = 1;

    final dx = size.width / 3;
    final dy = size.height / 3;

    for (int i = 0; i < 4; i++) {
      canvas.drawLine(Offset(dx * i, 0), Offset(dx * i, size.height), paint);
      canvas.drawLine(Offset(0, dy * i), Offset(size.width, dy * i), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
