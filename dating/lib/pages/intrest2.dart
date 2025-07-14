import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/content.dart';
import 'package:zypeme/pages/progress_bar.dart';

class IntrestPage2 extends StatefulWidget {
  const IntrestPage2({super.key});
  @override
  IntrestPage2State createState() => IntrestPage2State();
}

class IntrestPage2State extends State<IntrestPage2>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _imageOffsetX = 0.0;
  double _sliderValue = 0;

  int currentPage = 4;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ProgressBar(currentPage: currentPage, totalPages: 10),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: screenHeight * 0.14,
                          bottom: screenHeight * 0.04,
                          left: screenWidth * 0.09,
                          right: screenWidth * 0.12,
                        ),
                        width: double.infinity,
                        child: Text(
                          "Set Your Swipe\nZone!",
                          style: GoogleFonts.ptSerifCaption(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        child: Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.red,
                                thumbColor: Colors.orange,
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 12,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Slider(
                                    overlayColor: const WidgetStatePropertyAll(
                                      Colors.white,
                                    ),
                                    activeColor: const Color.fromARGB(
                                      255,
                                      234,
                                      77,
                                      197,
                                    ),
                                    value: _sliderValue,
                                    min: 0,
                                    max: 100,
                                    divisions: 10,
                                    label: _sliderValue.round().toString(),
                                    onChanged: (value) {
                                      setState(() {
                                        _sliderValue = value;
                                        currentPage = 5;
                                      });
                                    },
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.7,
                                    top: screenHeight * 0.03,
                                    child: Text(
                                      "${_sliderValue.toInt()} Km",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          255,
                                          195,
                                          193,
                                          193,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.04,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          margin: EdgeInsets.only(bottom: screenHeight * 0.08),
                          width: double.infinity,
                          child: Column(
                            children: [
                              IntrinsicWidth(
                                child: IntrinsicHeight(
                                  child: Stack(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        child:
                                            _sliderValue != 0
                                                ? Container(
                                                  width: screenWidth * 0.75,
                                                  height: screenHeight * 0.08,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          388,
                                                        ),
                                                    gradient:
                                                        const LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(
                                                              255,
                                                              232,
                                                              99,
                                                              214,
                                                            ),
                                                            Color.fromARGB(
                                                              255,
                                                              238,
                                                              176,
                                                              237,
                                                            ),
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end:
                                                              Alignment
                                                                  .bottomRight,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        screenHeight * 0.01,
                                                    horizontal:
                                                        screenWidth * 0.03,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onHorizontalDragUpdate: (
                                                          details,
                                                        ) {
                                                          setState(() {
                                                            _imageOffsetX +=
                                                                details
                                                                    .primaryDelta!;
                                                          });
                                                        },
                                                        onHorizontalDragEnd: (
                                                          details,
                                                        ) {
                                                          if (_imageOffsetX >
                                                              150) {
                                                            Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ContentPage(),
                                                              ),
                                                            ).then((value) {
                                                              if (value ==
                                                                  true) {
                                                                setState(() {});
                                                              }
                                                            });
                                                          } else {
                                                            setState(() {
                                                              _imageOffsetX =
                                                                  0.0;
                                                            });
                                                          }
                                                        },
                                                        child: Transform.translate(
                                                          offset: Offset(
                                                            _imageOffsetX,
                                                            0,
                                                          ),
                                                          child: Stack(
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    screenWidth *
                                                                    0.1,
                                                                height:
                                                                    screenWidth *
                                                                    0.1,
                                                                child: FadeTransition(
                                                                  opacity:
                                                                      _controller,
                                                                  child: Image.network(
                                                                    "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4f13f915-b4a9-41b1-8ff1-8f257803adae",
                                                                    fit:
                                                                        BoxFit
                                                                            .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              const Icon(
                                                                size: 40,
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      141,
                                                                      3,
                                                                      120,
                                                                    ),
                                                                Icons
                                                                    .chevron_right,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Text(
                                                        "Swipe to Continue",
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                              0.045,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                : Container(
                                                  width: screenWidth * 0.75,
                                                  height: screenHeight * 0.08,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                            128,
                                                            237,
                                                            231,
                                                            237,
                                                          ),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          388,
                                                        ),
                                                    color: const Color.fromARGB(
                                                      255,
                                                      244,
                                                      241,
                                                      241,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        screenHeight * 0.01,
                                                    horizontal:
                                                        screenWidth * 0.02,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Image.network(
                                                            "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/9236cc21-1a33-4f90-9d51-c57046764bf6",
                                                            width:
                                                                screenWidth *
                                                                0.13,
                                                            height:
                                                                screenWidth *
                                                                0.13,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          const Positioned(
                                                            left: 11,
                                                            top: 10,
                                                            child: Icon(
                                                              size: 30,
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    151,
                                                                    149,
                                                                    149,
                                                                  ),
                                                              Icons
                                                                  .chevron_right,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.04,
                                                      ),
                                                      Text(
                                                        "Swipe to continue",
                                                        style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                              0.035,
                                                          color:
                                                              const Color.fromARGB(
                                                                255,
                                                                188,
                                                                185,
                                                                185,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
