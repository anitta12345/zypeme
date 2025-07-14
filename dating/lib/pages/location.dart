import 'package:flutter/material.dart';
import 'package:zypeme/connect.dart';

class LocationPermissionPage extends StatefulWidget {
  final String email;
  final String phone;
  const LocationPermissionPage({
    required this.email,
    required this.phone,
    super.key,
  });

  @override
  State<LocationPermissionPage> createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {
  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: screenW * 0.2, right: screenW * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Location Icon
              Container(
                width: screenW * 0.4,
                height: screenW * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF4FD8), Color(0xFFD2188E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: screenW * 0.2,
                  ),
                ),
              ),

              SizedBox(height: screenH * 0.06),

              /// Title
              Text(
                "Your location ?",
                style: TextStyle(
                  fontSize: screenW * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: screenH * 0.015),

              /// Subtitle
              Text(
                "Find meaningful connections near you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenW * 0.03,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: screenH * 0.08),

              /// Gradient Button
              SizedBox(
                width: screenW * 0.75,
                height: screenH * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Handle location permission request
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => LetsConnect(
                                phone: widget.phone,
                                email: widget.email,
                              ),
                        ),
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF3BDE), Color(0xFFFFB8F1)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Allow location access",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenW * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
