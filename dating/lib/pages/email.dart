import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zypeme/pages/location.dart';

class EMail extends StatefulWidget {
  final String phone;
  const EMail({required this.phone, super.key});
  @override
  EMailState createState() => EMailState();
}

class EMailState extends State<EMail> {
  final _formKey = GlobalKey<FormState>();
  String textField1 = '';
  bool _isValid = false;
  final TextEditingController _email = TextEditingController();

  void _validate() {
    setState(() {
      _isValid = _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final w = mq.size.width;
    final h = mq.size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: w,
          height: h,
          color: Colors.white,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.1),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.13, bottom: h * 0.05),
                    child: Text(
                      "Enter your Email",
                      style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.06,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: w * 0.75,
                      height: h * 0.075,
                      padding: EdgeInsets.symmetric(
                        horizontal: w * 0.03,
                        vertical: h * 0.01,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF6F2F2),
                      ),
                      child: TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Color(0xFF806F6F),
                          fontSize: w * 0.04,
                        ),
                        onChanged: (value) {
                          setState(() {
                            textField1 = value;
                          });
                          _validate();
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your Email",
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: h * 0.015),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.015),
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.13, bottom: h * 0.03),
                    child: Text(
                      "To keep your account safe verify your email",
                      style: TextStyle(color: Colors.blue, fontSize: w * 0.025),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: w * 0.75,
                      height: h * 0.075,
                      child: ElevatedButton(
                        onPressed:
                            _isValid
                                ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Form Submitted!')),
                                  );
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x40000000),
                                blurRadius: 6,
                                offset: Offset(0, 1),
                              ),
                            ],
                            // gradient: LinearGradient(
                            //   begin: Alignment(-1, 1),
                            //   end: Alignment(1, 1),
                            //   colors:
                            //       _isValid
                            //           ? [
                            //             Color.fromARGB(255, 225, 185, 213),
                            //             Color.fromRGBO(230, 102, 200, 1),
                            //           ]
                            //           : [
                            //             Color.fromARGB(255, 191, 189, 189),
                            //             Color.fromARGB(255, 191, 189, 189),
                            //           ],
                            // ),
                            color:
                                _isValid
                                    ? const Color.fromARGB(255, 230, 94, 216)
                                    : Colors.grey.shade400,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (_isValid) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => LocationPermissionPage(
                                          phone: widget.phone,
                                          email: _email.text,
                                        ),
                                  ),
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: w * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  // Center(
                  //   child: Container(
                  //     width: w * 0.75,
                  //     height: h * 0.07,
                  //     padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Color(0x4F000000), width: 1),
                  //       borderRadius: BorderRadius.circular(15),
                  //       color: Colors.white,
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: w * 0.15,
                  //           height: h * 0.05,
                  //           child: Image.network(
                  //             "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4fa4c92a-a582-420b-9371-22e5fec24604",
                  //             fit: BoxFit.fill,
                  //           ),
                  //         ),
                  //         SizedBox(width: w * 0.02),
                  //         Expanded(
                  //           child: Text(
                  //             "Sign in with Your Google",
                  //             style: TextStyle(
                  //               color: Color(0xFF050404),
                  //               fontSize: w * 0.04,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: h * 0.05),
                  // Center(
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => LocationPermissionPage(),
                  //         ),
                  //       );
                  //     },
                  //     child: Text(
                  //       "skip",
                  //       style: TextStyle(
                  //         color: Color(0xFFC4BFBF),
                  //         fontSize: w * 0.05,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: h * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
