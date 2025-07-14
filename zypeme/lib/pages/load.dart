import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zypeme/pages/getstartface.dart';
// Replace with your next page

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    // Delay for 2 seconds before navigating
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FaceIDScreen(), // Replace this
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const Center(
        child: Image(
          image: AssetImage('assets/images/gifloading.gif'),
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
