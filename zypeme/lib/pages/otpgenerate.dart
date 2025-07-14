import 'package:flutter/material.dart';

class Otp extends StatelessWidget {
  final String value; // phone number
  final String otp; // 4-digit OTP

  const Otp({super.key, required this.value, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Phone: $value"),
            Text("OTP: $otp"), // For testing only (remove in production)
          ],
        ),
      ),
    );
  }
}
