import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zypeme/pages/crop.dart';

class ImageSourceSelectionScreen extends StatefulWidget {
  final void Function(File croppedFile, String? prompt) onImageCropped;

  const ImageSourceSelectionScreen({super.key, required this.onImageCropped});

  @override
  State<ImageSourceSelectionScreen> createState() =>
      _ImageSourceSelectionScreenState();
}

class _ImageSourceSelectionScreenState
    extends State<ImageSourceSelectionScreen> {
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      final imageBytes = await picked.readAsBytes();
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => CustomCropScreen(
                imageBytes: imageBytes,
                onCropped: (file, prompt) {},
              ),
        ),
      );

      if (result != null && result is Map) {
        widget.onImageCropped(result['file'], result['prompt']);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: h * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(height: h * 0.05),

              // Camera + Gallery in a Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconCard(
                    w,
                    h,
                    Icons.photo_camera,
                    () => _pickImage(context, ImageSource.camera),
                  ),
                  _buildIconCard(
                    w,
                    h,
                    Icons.photo,
                    () => _pickImage(context, ImageSource.gallery),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconCard(double w, double h, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * 0.18,
        width: w * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(w * 0.05),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(child: Icon(icon, size: w * 0.1, color: Colors.black)),
      ),
    );
  }
}
