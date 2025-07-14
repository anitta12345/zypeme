import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zypeme/pages/email.dart';
import 'package:zypeme/pages/phonenumber.dart';

class Otp extends StatefulWidget {
  final String value;
  final String otp;
  const Otp({required this.value, required this.otp, super.key});
  @override
  OtpState createState() => OtpState();
}

class OtpState extends State<Otp> {
  late Timer _timer;
  int _secondsRemaining = 120;
  late String phone;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();
  bool _allFieldsFilled = false;
  bool _timerEnded = false;

  final FocusNode focus1 = FocusNode();
  final FocusNode focus2 = FocusNode();
  final FocusNode focus3 = FocusNode();
  final FocusNode focus4 = FocusNode();

  // Show OTP dialog with phone number and OTP
  void showOtpDialog(BuildContext context, String phone, String otp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("OTP Details"),
          content: Text("Phone: $phone\nOTP: $otp"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Check if the entered OTP matches the expected OTP
  bool isOtpCorrect() {
    String enteredOtp = otp1.text + otp2.text + otp3.text + otp4.text;
    return enteredOtp == widget.otp;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOtpDialog(context, widget.value, widget.otp);
    });
    _startTimer();
    phone = widget.value;
    otp1.addListener(_checkFields);
    otp2.addListener(_checkFields);
    otp3.addListener(_checkFields);
    otp4.addListener(_checkFields);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _timerEnded = true;
        });
        _timer.cancel();
      }
    });
  }

  void _checkFields() {
    setState(() {
      _allFieldsFilled =
          otp1.text.isNotEmpty &&
          otp2.text.isNotEmpty &&
          otp3.text.isNotEmpty &&
          otp4.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    super.dispose();
  }

  String getFormattedTime() {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final boxSize = width * 0.18;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            width: double.infinity,
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: height * 0.12),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Column(
                    children: [
                      Text(
                        "Enter the 4-digit OTP",
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            phone,
                            style: TextStyle(fontSize: width * 0.045),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => Mobile()),
                              );
                            },
                            child: Text("Edit"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildOtpBox(focus1, otp1, focus2, boxSize),
                      _buildOtpBox(focus2, otp2, focus3, boxSize),
                      _buildOtpBox(focus3, otp3, focus4, boxSize),
                      _buildOtpBox(focus4, otp4, null, boxSize),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  _secondsRemaining > 0
                      ? Text(
                        'Time: ${getFormattedTime()}',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: width * 0.04,
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("OTP not received? "),
                          TextButton(
                            onPressed: () {
                              // TODO: Resend logic
                            },
                            child: Text("RESEND"),
                          ),
                        ],
                      ),
                  SizedBox(height: height * 0.06),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.07,
                    child: ElevatedButton(
                      onPressed:
                          _allFieldsFilled
                              ? () {
                                if (isOtpCorrect()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "OTP Verified Successfully!",
                                      ),
                                    ),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EMail(phone: phone),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: Text("Incorrect OTP"),
                                          content: Text(
                                            "The entered OTP does not match. Please try again.",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: Text("OK"),
                                            ),
                                          ],
                                        ),
                                  );
                                }
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor:
                            _allFieldsFilled
                                ? const Color.fromARGB(255, 230, 94, 216)
                                : Colors.grey.shade400,
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildOtpBox(
    FocusNode node,
    TextEditingController controller,
    FocusNode? nextFocus,
    double size,
  ) {
    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: _timerEnded ? Colors.red : Colors.grey.shade400,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        focusNode: node,
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: size * 0.4),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (val) {
          if (val.length == 1 && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          } else if (val.length == 1 && nextFocus == null) {
            FocusScope.of(context).unfocus();
          }
        },
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
