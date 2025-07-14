import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zypeme/get_start.dart';
// Replace with your next page

class LoadingPage1 extends StatefulWidget {
  const LoadingPage1({super.key});

  @override
  State<LoadingPage1> createState() => _LoadingPage1State();
}

class _LoadingPage1State extends State<LoadingPage1> {
  @override
  void initState() {
    super.initState();

    // Delay for 2 seconds before navigating
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GetStart(), // Replace this
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/gifloading.gif',
          width: w * 0.6, // 60% of screen width
          height: h * 0.3, // 30% of screen height
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
