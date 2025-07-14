import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zypeme/pages/load.dart';
import 'package:zypeme/pages/progress_bar.dart';
import 'package:zypeme/pages/selection.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  AddState createState() => AddState();
}

class AddState extends State<Add> with TickerProviderStateMixin {
  double _imageOffsetX = 0.0;
  late AnimationController _controller;
  List<File?> selectedImages = List.generate(4, (_) => null);

  int currentPage = 7;
  void _onlne() {
    setState(() {
      currentPage = allImagesSelected ? 8 : 7;
    });
  }

  void openImageSourcePicker(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ImageSourceSelectionScreen(
              onImageCropped: (croppedFile, prompt) {
                setState(() {
                  selectedImages[index] = croppedFile;
                  _onlne(); // Update currentPage when an image is selected
                });
              },
            ),
      ),
    );
  }

  void removeImage(int index) {
    setState(() {
      selectedImages[index] = null;
      _onlne(); // Update currentPage when an image is removed
    });
  }

  bool get allImagesSelected => selectedImages.every((img) => img != null);
  bool _isLoading = true;
  Future<void> _loadPage() async {
    // Simulate a delay (e.g., loading from network or disk)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false; // page is ready
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _loadPage();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    final imageWidth = screenW * 0.4;
    final imageHeight = screenH * 0.22;

    if (_isLoading) {
      // Show loading spinner
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.pinkAccent,
            strokeWidth: 4.0,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenW * 0.05),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ProgressBar(currentPage: currentPage, totalPages: 10),
                ),
                SizedBox(height: screenH * 0.02),
                Text(
                  "Let’s see the latest you",
                  style: TextStyle(
                    fontSize: screenW * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenH * 0.01),
                Text(
                  "drop your freshest pic",
                  style: TextStyle(fontSize: screenW * 0.045),
                ),
                SizedBox(height: screenH * 0.04),

                /// Image Grid
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenW * 0.01),
                  child: Wrap(
                    spacing: screenW * 0.08,
                    runSpacing: screenH * 0.02,
                    children: List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () => openImageSourcePicker(index),
                        child: Stack(
                          children: [
                            Container(
                              width: imageWidth,
                              height: imageHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  screenW * 0.02,
                                ),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  screenW * 0.0,
                                ),
                                child:
                                    selectedImages[index] != null
                                        ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              screenW * 0.06,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              screenW * 0.06,
                                            ), // Apply the same radius here
                                            child: Image.file(
                                              selectedImages[index]!,
                                              fit:
                                                  BoxFit
                                                      .cover, // Use `cover` for better crop inside rounded corner
                                              width: imageWidth,
                                              height: imageHeight,
                                            ),
                                          ),
                                        )
                                        : Image.network(
                                          "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/ff33e8fa-3ab5-419c-bd9b-7680806f8fe1",
                                          fit: BoxFit.contain,
                                          width: imageWidth,
                                          height: imageHeight,
                                        ),
                              ),
                            ),
                            if (selectedImages[index] != null)
                              Positioned(
                                top: screenW * 0.01,
                                right: screenW * 0.01,
                                child: GestureDetector(
                                  onTap: () => removeImage(index),
                                  child: CircleAvatar(
                                    radius: screenW * 0.03,
                                    backgroundColor: Colors.black54,
                                    child: Icon(
                                      Icons.close,
                                      size: screenW * 0.035,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: screenH * 0.025),
                Padding(
                  padding: EdgeInsets.only(right: screenW * 0.15),
                  child: Text(
                    "Upload 4 photos to make your account\nstand out",
                    style: TextStyle(fontSize: screenW * 0.035),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: screenH * 0.05),

                /// Swipe Button (Enabled or Disabled)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  child:
                      allImagesSelected
                          ? _buildSwipeButton(screenW)
                          : _buildDisabledButton(screenW, screenH),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeButton(double screenW) {
    //_onlne(); // Call _onlne to update currentPage if needed
    return Container(
      width: screenW * 0.7,
      height: screenW * 0.15,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(388),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 232, 99, 214),
            Color.fromARGB(255, 238, 176, 237),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.all(screenW * 0.015),
      child: Row(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _imageOffsetX += details.primaryDelta!;
              });
            },
            onHorizontalDragEnd: (_) {
              if (_imageOffsetX > screenW * 0.3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoadingPage()),
                );
              } else {
                setState(() {
                  _imageOffsetX = 0.0;
                });
              }
            },
            child: Transform.translate(
              offset: Offset(_imageOffsetX, 0),
              child: Stack(
                children: [
                  FadeTransition(
                    opacity: _controller,
                    child: Image.network(
                      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4f13f915-b4a9-41b1-8ff1-8f257803adae",
                      width: screenW * 0.11,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenW * 0.0001),
                    child: Icon(
                      Icons.chevron_right,
                      size: screenW * 0.12,
                      color: const Color.fromARGB(255, 141, 3, 120),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: screenW * 0.03),
          Text(
            "Swipe to Continue",
            style: TextStyle(
              fontSize: screenW * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisabledButton(double screenW, double screenH) {
    return Container(
      width: screenW * 0.8,
      height: screenW * 0.15,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 10),
          ),
        ],
        color: const Color.fromARGB(255, 244, 241, 241),
        borderRadius: BorderRadius.circular(388),
        border: Border.all(color: const Color.fromARGB(128, 237, 231, 237)),
      ),
      padding: EdgeInsets.all(screenW * 0.015),
      child: Row(
        children: [
          Image.network(
            "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/9236cc21-1a33-4f90-9d51-c57046764bf6",
            width: screenW * 0.13,
            height: screenW * 0.13,
            fit: BoxFit.fill,
          ),
          SizedBox(width: screenW * 0.04),
          Text(
            "Swipe to continue",
            style: TextStyle(
              fontSize: screenW * 0.038,
              color: const Color.fromARGB(255, 188, 185, 185),
            ),
          ),
        ],
      ),
    );
  }
}
