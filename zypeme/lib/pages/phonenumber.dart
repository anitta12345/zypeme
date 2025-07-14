import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:zypeme/pages/otp.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});
  @override
  MobileState createState() => MobileState();
}

class MobileState extends State<Mobile> {
  String textField1 = '';
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  final TextEditingController _phone = TextEditingController();

  void _validate() {
    setState(() {
      _isValid = _formKey.currentState!.validate();
    });
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^[6789]\d{9}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  /// Generate 4-digit random number
  String generateOtp() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString(); // 1000–9999
  }

  /// Send phone number and OTP to backend
  Future<void> sendOtpToServer(String phone, String otp) async {
    final url = Uri.parse(
      'https://your-domain.com/api/send-otp',
    ); // Replace with your API

    try {
      final response = await http.post(url, body: {'phone': phone, 'otp': otp});

      if (response.statusCode == 200) {
        print('OTP sent successfully!');
      } else {
        print('Failed to send OTP. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.1),
                    Text(
                      "Enter your number",
                      style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.06,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.06),

                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03,
                            vertical: height * 0.015,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF6F2F2),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "IN +91",
                                style: TextStyle(
                                  color: const Color(0xFF806F6F),
                                  fontSize: width * 0.04,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Image.network(
                                "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/945f25d9-6fa2-4395-9926-03a9456e99dc",
                                width: width * 0.03,
                                height: height * 0.01,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: width * 0.03),

                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: height * 0.015,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF6F2F2),
                            ),
                            child: TextFormField(
                              controller: _phone,
                              validator: validatePhoneNumber,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                color: const Color(0xFF806F6F),
                                fontSize: width * 0.045,
                              ),
                              onChanged: (value) {
                                setState(() => textField1 = value);
                                _validate();
                              },
                              decoration: const InputDecoration(
                                hintText: "Mobile Number",
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.03),
                    Text(
                      "We will text you a code to verify",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.045,
                      ),
                    ),
                    SizedBox(height: height * 0.1),

                    SizedBox(
                      width: double.infinity,
                      height: height * 0.07,
                      child: ElevatedButton(
                        onPressed:
                            _isValid
                                ? () async {
                                  String phone = _phone.text.trim();
                                  String otp = generateOtp();

                                  await sendOtpToServer(phone, otp);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => Otp(
                                            value: phone,
                                            otp:
                                                otp, // You can use this in OTP screen
                                          ),
                                    ),
                                  );
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color:
                                _isValid
                                    ? const Color.fromARGB(255, 230, 94, 216)
                                    : Colors.grey.shade400,
                          ),
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
