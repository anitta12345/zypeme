import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/intrest2.dart';
import 'package:zypeme/pages/progress_bar.dart';

class IntrestPage1 extends StatefulWidget {
  const IntrestPage1({super.key});
  @override
  IntrestPage1State createState() => IntrestPage1State();
}

class IntrestPage1State extends State<IntrestPage1>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _imageOffsetX = 0.0;
  int? _selectedIndex;
  String? _selectedValue;

  int currentPage = 3;

  final List<String> options = [
    "Long-term Relationship",
    "Long-term\nopen to short",
    "Short-term\nopen to long",
    "Besties",
    "New friends",
    "Still Figuring it out",
  ];
  final List<String> images = [
    "assets/images/relation.png",
    "assets/images/long.png",
    "assets/images/short.png",
    "assets/images/besties.png",
    "assets/images/new.png",
    "assets/images/still.png",
  ];

  void _onSelect(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedValue = options[index];
    });
    _onlne();
  }

  void _onlne() {
    if (_selectedValue != null) {
      setState(() {
        currentPage = 4;
      });
    }
  }

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
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ProgressBar(currentPage: currentPage, totalPages: 10),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFFFFFFF),
                  width: double.infinity,
                  height: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.14,
                            bottom: screenHeight * 0.04,
                            left: screenWidth * 0.1,
                            right: screenWidth * 0.12,
                          ),
                          width: double.infinity,
                          child: Text(
                            "What Bring You\nhere?",
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
                          padding: EdgeInsets.only(left: screenWidth * 0.09),
                          child: Column(
                            children: [
                              Wrap(
                                spacing: screenWidth * 0.03,
                                runSpacing: screenWidth * 0.03,
                                children: List.generate(options.length, (
                                  index,
                                ) {
                                  return GestureDetector(
                                    onTap: () => _onSelect(index),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.025,
                                      ),
                                      width: screenWidth * 0.25,
                                      height: screenHeight * 0.14,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.2,
                                            ),
                                            offset: const Offset(4, 4),
                                            blurRadius: 6,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                        color:
                                            _selectedIndex == index
                                                ? const Color.fromARGB(
                                                  255,
                                                  233,
                                                  142,
                                                  227,
                                                )
                                                : const Color.fromARGB(
                                                  255,
                                                  250,
                                                  249,
                                                  249,
                                                ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                            31,
                                            168,
                                            163,
                                            163,
                                          ),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            images[index],
                                            width: screenWidth * 0.15,
                                            height: screenHeight * 0.06,
                                          ),
                                          SizedBox(
                                            height: screenHeight * 0.005,
                                          ),
                                          Text(
                                            options[index],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.033,
                                              color:
                                                  _selectedIndex == index
                                                      ? Colors.white
                                                      : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(height: screenHeight * 0.05),
                            ],
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: screenHeight * 0.08,
                            ),
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
                                              _selectedValue != null
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
                                                                Alignment
                                                                    .topLeft,
                                                            end:
                                                                Alignment
                                                                    .bottomRight,
                                                          ),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical:
                                                              screenHeight *
                                                              0.008,
                                                          horizontal:
                                                              screenWidth *
                                                              0.03,
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
                                                                      (
                                                                        context,
                                                                      ) =>
                                                                          IntrestPage2(),
                                                                ),
                                                              );
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
                                                                  Icons
                                                                      .chevron_right,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        141,
                                                                        3,
                                                                        120,
                                                                      ),
                                                                  size: 40,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenWidth *
                                                              0.03,
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
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            388,
                                                          ),
                                                      color:
                                                          const Color.fromARGB(
                                                            255,
                                                            244,
                                                            241,
                                                            241,
                                                          ),
                                                    ),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical:
                                                              screenHeight *
                                                              0.008,
                                                          horizontal:
                                                              screenWidth *
                                                              0.03,
                                                        ),
                                                    child: Row(
                                                      children: [
                                                        Stack(
                                                          alignment:
                                                              Alignment.center,
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
                                                              child: Icon(
                                                                Icons
                                                                    .chevron_right,
                                                                size: 30,
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      151,
                                                                      149,
                                                                      149,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              screenWidth *
                                                              0.04,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
