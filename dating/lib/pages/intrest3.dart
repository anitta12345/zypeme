import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/datepage.dart';

class IntrestPage3 extends StatefulWidget {
  const IntrestPage3({super.key});
  @override
  IntrestPage3State createState() => IntrestPage3State();
}

class IntrestPage3State extends State<IntrestPage3>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _imageOffsetX = 0.0;
  double _sliderValue = 0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true); // Repeats the fade in/out
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFFFFFFFF),
                  width: double.infinity,
                  height: double.infinity,
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 90,
                              bottom: 8,
                              left: 36,
                              right: 40,
                            ),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Text(
                                  "Mention Your Intrestes?",
                                  style: GoogleFonts.ptSerifCaption(
                                    textStyle: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 10),
                                //   child: Text(
                                //     "Do their habits Swipe Yours? Let's hope they shower daily. you go first",
                                //     style: GoogleFonts.ptSerifCaption(
                                //       textStyle: TextStyle(fontSize: 12),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Divider(
                            color: const Color.fromARGB(
                              255,
                              233,
                              231,
                              231,
                            ), // Line color
                            thickness: 5, // Line thickness
                            // indent: 9, // Left spacing
                            // endIndent: 10, // Right spacing
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  30,
                                  (index) => ListTile(
                                    title: Text('Item ${index + 1}'),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          IntrinsicHeight(
                            child: Container(
                              color: const Color.fromARGB(255, 240, 238, 238),
                              margin: const EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  IntrinsicWidth(
                                    child: IntrinsicHeight(
                                      child: Stack(
                                        children: [
                                          AnimatedContainer(
                                            duration: Duration(
                                              milliseconds: 500,
                                            ),
                                            child:
                                                _sliderValue != 0
                                                    ? IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          width: 300,
                                                          height: 60,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  388,
                                                                ),
                                                            gradient: LinearGradient(
                                                              colors: [
                                                                const Color.fromARGB(
                                                                  255,
                                                                  232,
                                                                  99,
                                                                  214,
                                                                ),
                                                                const Color.fromARGB(
                                                                  255,
                                                                  238,
                                                                  176,
                                                                  237,
                                                                ),
                                                              ], // Gradient colors
                                                              begin:
                                                                  Alignment
                                                                      .topLeft, // Start position
                                                              end:
                                                                  Alignment
                                                                      .bottomRight, // End position
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.only(
                                                                top: 5,
                                                                bottom: 5,
                                                                left: 11,
                                                                right: 11,
                                                              ),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets.only(
                                                                      right: 11,
                                                                    ),
                                                                width: 50,
                                                                height: 50,
                                                                child: SizedBox(
                                                                  width:
                                                                      MediaQuery.of(
                                                                        context,
                                                                      ).size.width *
                                                                      0.2,
                                                                  child: GestureDetector(
                                                                    onHorizontalDragUpdate: (
                                                                      details,
                                                                    ) {
                                                                      setState(() {
                                                                        _imageOffsetX +=
                                                                            details.primaryDelta!;
                                                                      });
                                                                    },
                                                                    onHorizontalDragEnd: (
                                                                      details,
                                                                    ) {
                                                                      if (_imageOffsetX >
                                                                          150) {
                                                                        // Check if swipe is far enough
                                                                        Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder:
                                                                                (
                                                                                  context,
                                                                                ) =>
                                                                                    DatePage1(),
                                                                          ), // Navigate
                                                                        );
                                                                      } else {
                                                                        setState(() {
                                                                          _imageOffsetX =
                                                                              0.0; // Reset if swipe isn’t enough
                                                                        });
                                                                      }
                                                                    },
                                                                    child: Transform.translate(
                                                                      offset: Offset(
                                                                        _imageOffsetX,
                                                                        0,
                                                                      ), // Moves the image
                                                                      child: SizedBox(
                                                                        width:
                                                                            MediaQuery.of(
                                                                              context,
                                                                            ).size.width *
                                                                            0.4,
                                                                        child: Stack(
                                                                          children: [
                                                                            FadeTransition(
                                                                              opacity:
                                                                                  _controller,
                                                                              child: Image.network(
                                                                                "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4f13f915-b4a9-41b1-8ff1-8f257803adae",
                                                                                fit:
                                                                                    BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                            Icon(
                                                                              size:
                                                                                  50,
                                                                              color: const Color.fromARGB(
                                                                                255,
                                                                                141,
                                                                                3,
                                                                                120,
                                                                              ),
                                                                              Icons.chevron_right,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              Text(
                                                                "Swipe to Continue",
                                                                style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    : Container(
                                                      width: 300,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color.fromARGB(
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
                                                        color: Color.fromARGB(
                                                          255,
                                                          244,
                                                          241,
                                                          241,
                                                        ),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.only(
                                                            top: 5,
                                                            bottom: 5,
                                                            left: 5,
                                                            right: 5,
                                                          ),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets.only(
                                                                  right: 16,
                                                                ),
                                                            width: 50,
                                                            height: 50,
                                                            child: Stack(
                                                              children: [
                                                                Image.network(
                                                                  "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/9236cc21-1a33-4f90-9d51-c57046764bf6",
                                                                  fit:
                                                                      BoxFit
                                                                          .fill,
                                                                ),
                                                                Positioned(
                                                                  left: 11,
                                                                  top: 10,
                                                                  child: Icon(
                                                                    size: 30,
                                                                    color:
                                                                        const Color.fromARGB(
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
                                                          ),
                                                          IntrinsicHeight(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    vertical:
                                                                        13,
                                                                  ),
                                                              width: 154,
                                                              child: Text(
                                                                "Swipe to continue",
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  color:
                                                                      const Color.fromARGB(
                                                                        255,
                                                                        188,
                                                                        185,
                                                                        185,
                                                                      ),
                                                                ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
