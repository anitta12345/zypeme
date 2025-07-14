import 'package:flutter/material.dart';
import 'package:zypeme/pages/phonenumber.dart';

class GustPage extends StatefulWidget {
  const GustPage({super.key});
  @override
  GustPageState createState() => GustPageState();
}

class GustPageState extends State<GustPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and button Stack
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.4,
                          child: Image.asset(
                            "assets/images/1.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          left: width * 0.15,
                          right: width * 0.15,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Mobile(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(40),
                            splashColor: Colors.black.withOpacity(0.2),
                            child: Container(
                              height: height * 0.07,
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 225, 185, 213),
                                    Color.fromRGBO(230, 102, 200, 1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Text(
                                "Login With Your Number",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.07),

                    // OR Divider
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(color: Colors.grey, thickness: 1),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "or",
                              style: TextStyle(
                                fontSize: width * 0.045,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: Colors.grey, thickness: 1),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.04),

                    // Social Buttons
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     _buildSocialIcon(
                    //       "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/35c7f775-6101-4e9f-b1d6-f9e9a6f73f87",
                    //       width,
                    //       height,
                    //     ),
                    //     SizedBox(width: width * 0.03),
                    //     _buildSocialIcon(
                    //       "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/c92ec1a5-5d9b-4c15-b0b9-190960927532",
                    //       width,
                    //       height,
                    //     ),
                    //     SizedBox(width: width * 0.03),
                    //     _buildSocialIcon(
                    //       "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/bfa56b25-6aab-42d1-9fc5-cb1b82a1b827",
                    //       width,
                    //       height,
                    //     ),
                    //   ],
                    // ),
                    //SizedBox(height: height * 0.05),

                    // Continue as Guest
                    Center(
                      child: Text(
                        "Continue as a Guest",
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color: const Color.fromARGB(255, 47, 82, 196),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.05),

                    // Terms Text
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Text(
                        "*By Tapping “Sign in“ you agree to our terms. Learn how we process your data in our privacy and cookie policy.",
                        style: TextStyle(
                          fontSize: width * 0.028,
                          color: Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(String url, double width, double height) {
    return SizedBox(
      width: width * 0.18,
      height: height * 0.06,
      child: Image.network(url, fit: BoxFit.cover),
    );
  }
}
