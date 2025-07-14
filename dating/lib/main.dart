import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zypeme/pages/gallery.dart';
import 'package:zypeme/pages/phonenumber.dart';
import 'package:zypeme/pages/selection.dart';
import 'package:zypeme/pages/splash1.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ScreenUtilInit(
      designSize: Size(
        375,
        812,
      ), // your Figma or design size (usually iPhone X for mobile)
      minTextAdapt: true,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Mobile());
  }
}

class Zypeme extends StatefulWidget {
  const Zypeme({super.key});
  @override
  ZypemeState createState() => ZypemeState();
}

class ZypemeState extends State<Zypeme> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Bounce Effect
    _bounceAnimation = Tween<double>(
      begin: 0.5,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    // Start Animation
    // _controller.repeat(reverse: true);
    _controller.forward();

    // Navigate to GetStart() after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingPage1(),
        ), // Use existing GetStart page
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: Colors.white,
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset("assets/images/fbg.jpg", fit: BoxFit.cover),
              ),

              // Foreground Image with Bounce Animation
              Center(
                child: AnimatedBuilder(
                  animation: _bounceAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _bounceAnimation.value,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
