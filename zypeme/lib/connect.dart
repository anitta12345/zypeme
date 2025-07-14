import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/namepage.dart';

class LetsConnect extends StatefulWidget {
  final String email;
  final String phone;
  const LetsConnect({required this.email, required this.phone, super.key});
  @override
  LetsConnectState createState() => LetsConnectState();
}

class LetsConnectState extends State<LetsConnect> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: w,
          height: h,
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: w,
                  height: h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/fbg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.037,
                                left: w * 0.24,
                                top: h * 0.06,
                              ),
                              child: Text(
                                "Lets Connect",
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.08,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: w * 0.13),
                              child: Text(
                                "Welcome to Zypeme .",
                                style: GoogleFonts.ptSerif(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.065,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.025,
                                left: w * 0.24,
                              ),
                              child: Text(
                                "Let’s get you matched",
                                style: GoogleFonts.ptSerif(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.065,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.01,
                                left: w * 0.14,
                              ),
                              child: Text(
                                "Be real or be gone.",
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.053,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.018,
                                left: w * 0.2,
                                right: w * 0.04,
                              ),
                              width: double.infinity,
                              child: Text(
                                "No fake photos or misleading info—authenticity is sexy",
                                style: GoogleFonts.ptSerif(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.043,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.01,
                                left: w * 0.14,
                              ),
                              child: Text(
                                "No jerks, just vibes.",
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.053,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.018,
                                left: w * 0.21,
                                right: w * 0.04,
                              ),
                              width: double.infinity,
                              child: Text(
                                "Treat others how you’d want to be treated on your best date.",
                                style: GoogleFonts.ptSerif(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.043,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.01,
                                left: w * 0.14,
                              ),
                              child: Text(
                                "Report the weirdos.",
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.053,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.02,
                                left: w * 0.22,
                              ),
                              child: Text(
                                "If something feels off, report it.",
                                style: GoogleFonts.ptSerif(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.043,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.007,
                                left: w * 0.14,
                              ),
                              child: Text(
                                "Keep it fun, not funky.",
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.053,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: h * 0.037,
                                left: w * 0.232,
                                right: w * 0.04,
                              ),
                              width: double.infinity,
                              child: Text(
                                "Meet in public places. Tell a friend. Trust your gut. Safety first, sparks second",
                                style: GoogleFonts.ptSerif(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: w * 0.043,
                                  ),
                                ),
                              ),
                            ),
                            IntrinsicWidth(
                              child: IntrinsicHeight(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => NamePage1(
                                              email: widget.email,
                                              phone: widget.phone,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: w * 0.53,
                                    height: h * 0.07,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: [
                                          const Color.fromARGB(
                                            255,
                                            229,
                                            82,
                                            204,
                                          ),
                                          const Color.fromARGB(
                                            255,
                                            236,
                                            154,
                                            223,
                                          ),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x40000000),
                                          blurRadius: 6,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.only(
                                      top: h * 0.01,
                                      bottom: h * 0.006,
                                      left: w * 0.16,
                                    ),
                                    margin: EdgeInsets.only(
                                      left: w * 0.21,
                                      bottom: h * 0.037,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          color: Colors.white,
                                          Icons.thumb_up,
                                        ),
                                        SizedBox(width: w * 0.03),
                                        Text(
                                          "I Agree",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: w * 0.048,
                                            fontWeight: FontWeight.bold,
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
