import 'package:flutter/material.dart';
import 'package:zypeme/pages/guestpage.dart';

class GetStart extends StatefulWidget {
  const GetStart({super.key});
  @override
  GetStartState createState() => GetStartState();
}

class GetStartState extends State<GetStart>
    with SingleTickerProviderStateMixin {
  double _imageOffsetX = 0.0;
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          //height: height * 0.01,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.2,
                      width: double.infinity,
                      child: Image.network(
                        "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/63eb8367-f51f-4869-b1e3-f14a201b78fd",
                        fit: BoxFit.cover,
                      ),
                    ),
                    //SizedBox(height: height * 0.001),
                    SizedBox(
                      width: width * 0.7,
                      height: height * 0.3,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    //SizedBox(height: height * 0.015),
                    Text(
                      "Find Your Perfect",
                      style: TextStyle(
                        fontSize: width * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Companion",
                      style: TextStyle(
                        fontSize: width * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Text(
                        "Love starts with a swipe, but real connections begin here",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height * 0.06),

                    // Swipe Button
                    Container(
                      height: height * 0.070,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.12),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE8BADD), Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02,
                        vertical: height * 0.01,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.1,
                            child: GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                setState(() {
                                  _imageOffsetX += details.primaryDelta!;
                                });
                              },
                              onHorizontalDragEnd: (details) {
                                if (_imageOffsetX > width * 0.3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => GustPage(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _imageOffsetX = 0.0;
                                  });
                                }
                              },
                              child: Transform.translate(
                                offset: Offset(_imageOffsetX, 0),
                                child: FadeTransition(
                                  opacity: _controller,
                                  child: Image.network(
                                    "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/70a1af3a-a396-42c4-9544-5eb91b1cf28f",
                                    width: width * 0.4,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.2,
                            ),
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: width * 0.048,
                                color: const Color.fromARGB(255, 84, 82, 82),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
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
