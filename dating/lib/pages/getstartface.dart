import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/facepermission.dart';
import 'package:zypeme/pages/progress_bar.dart';

class FaceIDScreen extends StatelessWidget {
  const FaceIDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenW * 0.06,
            vertical: screenH * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row (Back and Skip)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, size: screenW * 0.07),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "skip",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenW * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ProgressBar(currentPage: 8, totalPages: 10),
              ),
              SizedBox(height: screenH * 0.04),

              /// Title
              Center(
                child: Text(
                  "Face Verfication",
                  style: GoogleFonts.ptSerifCaption(
                    textStyle: TextStyle(
                      fontSize: screenW * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenH * 0.05),

              /// Face ID Icon
              Center(
                child: Image.asset(
                  'assets/images/face.png',
                  width: screenW * 0.5,
                  height: screenW * 0.5,
                ),
              ),

              SizedBox(height: screenH * 0.04),

              /// Description Title
              Text(
                "Why we ask for Face ID access:",
                style: GoogleFonts.ptSerifCaption(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenW * 0.05,
                  ),
                ),
              ),

              SizedBox(height: screenH * 0.015),

              /// Description Content
              Text(
                "Prevent fake profiles and bots\n"
                "Enable quick and secure logins\n"
                "For verified account to access real connection",
                style: GoogleFonts.ptSerifCaption(
                  textStyle: TextStyle(fontSize: screenW * 0.034, height: 1.5),
                ),
              ),

              const Spacer(),

              /// Get Start Button
              Padding(
                padding: EdgeInsets.only(left: screenW * 0.1),
                child: Container(
                  width: screenW * 0.65,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEC77E9), Color(0xFFE5A6FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(screenW * 0.08),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PermissionRequestPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenW * 0.08),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: screenH * 0.02),
                      child: Text(
                        'Get Start',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenW * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenH * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
