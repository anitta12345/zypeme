import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/intrest.dart';
import 'package:zypeme/pages/progress_bar.dart';

class GenderPage1 extends StatefulWidget {
  const GenderPage1({super.key});
  @override
  GenderPage1State createState() => GenderPage1State();
}

class GenderPage1State extends State<GenderPage1>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _imageOffsetX = 0.0;
  int? _selectedIndex;
  String? _selectedValue;
  final List<String> options = ["Male", "Female", "Beyond gender", "Others"];
  late AnimationController _controller;

  int currentPage = 2;

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
        currentPage = 3;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
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

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenW,
          height: screenH,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ProgressBar(
                          currentPage: currentPage,
                          totalPages: 10,
                        ),
                      ),

                      /// Title
                      Container(
                        margin: EdgeInsets.only(
                          top: screenH * 0.14,
                          bottom: screenH * 0.035,
                          left: screenW * 0.08,
                          right: screenW * 0.1,
                        ),
                        child: Text(
                          "Mark Your Gender\ntag?",
                          style: GoogleFonts.ptSerifCaption(
                            textStyle: TextStyle(
                              fontSize: screenW * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      /// Gender Options
                      Padding(
                        padding: EdgeInsets.only(left: screenW * 0.08),
                        child: Wrap(
                          spacing: screenW * 0.05,
                          runSpacing: screenH * 0.015,
                          children: List.generate(options.length, (index) {
                            return GestureDetector(
                              onTap: () => _onSelect(index),
                              child: Container(
                                width: screenW * 0.38,
                                height: screenH * 0.065,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
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
                                child: Text(
                                  options[index],
                                  style: TextStyle(
                                    fontSize: screenW * 0.04,
                                    color:
                                        _selectedIndex == index
                                            ? Colors.white
                                            : Colors.black87,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      SizedBox(height: screenH * 0.06),

                      /// Swipe Button
                      Container(
                        margin: EdgeInsets.only(bottom: screenH * 0.12),
                        width: screenW,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  child:
                                      _selectedValue != null
                                          ? Container(
                                            width: screenW * 0.8,
                                            height: screenH * 0.075,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(388),
                                              gradient: const LinearGradient(
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
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenW * 0.03,
                                              vertical: screenH * 0.01,
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: screenW * 0.13,
                                                  height: screenW * 0.13,
                                                  child: GestureDetector(
                                                    onHorizontalDragUpdate: (
                                                      details,
                                                    ) {
                                                      setState(() {
                                                        _imageOffsetX +=
                                                            details
                                                                .primaryDelta!;
                                                      });
                                                    },
                                                    onHorizontalDragEnd: (_) {
                                                      if (_imageOffsetX >
                                                          screenW * 0.35) {
                                                        // Adjusted 150 to responsive
                                                        Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    IntrestPage1(),
                                                          ),
                                                        );
                                                      } else {
                                                        setState(() {
                                                          _imageOffsetX = 0.0;
                                                        });
                                                      }
                                                    },
                                                    child: Transform.translate(
                                                      offset: Offset(
                                                        _imageOffsetX,
                                                        0,
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          FadeTransition(
                                                            opacity:
                                                                _controller,
                                                            child: Image.network(
                                                              "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4f13f915-b4a9-41b1-8ff1-8f257803adae",
                                                              width:
                                                                  screenW *
                                                                  0.12,
                                                              height:
                                                                  screenW *
                                                                  0.12,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left:
                                                                screenW *
                                                                0.03, // responsive positioning
                                                            top: screenW * 0.02,
                                                            child: Icon(
                                                              Icons
                                                                  .chevron_right,
                                                              size:
                                                                  screenW *
                                                                  0.08, // previously 40
                                                              color:
                                                                  const Color.fromARGB(
                                                                    255,
                                                                    141,
                                                                    3,
                                                                    120,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenW * 0.025,
                                                ), // responsive spacing
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
                                          )
                                          : Container(
                                            width: screenW * 0.8,
                                            height: screenH * 0.075,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                  128,
                                                  237,
                                                  231,
                                                  237,
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(388),
                                              color: const Color.fromARGB(
                                                255,
                                                244,
                                                241,
                                                241,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenW * 0.04,
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: screenW * 0.13,
                                                  height: screenW * 0.13,
                                                  child: Stack(
                                                    children: [
                                                      Image.network(
                                                        "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/9236cc21-1a33-4f90-9d51-c57046764bf6",
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Positioned(
                                                        left: screenW * 0.03,
                                                        top: screenW * 0.025,
                                                        child: Icon(
                                                          Icons.chevron_right,
                                                          size: screenW * 0.08,
                                                          color:
                                                              const Color.fromARGB(
                                                                255,
                                                                151,
                                                                149,
                                                                149,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: screenW * 0.04),
                                                Text(
                                                  "Swipe to continue",
                                                  style: TextStyle(
                                                    fontSize: screenW * 0.035,
                                                    color: const Color.fromARGB(
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
                          ],
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
