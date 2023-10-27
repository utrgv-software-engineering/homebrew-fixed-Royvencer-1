import 'package:flutter/material.dart';
import 'dart:async';
import 'choose_device_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 2);
    return Timer(duration, navigateToDeviceScreen);
  }

  navigateToDeviceScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChooseDeviceScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set your branding background color
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0, // Start with 0.0 for hidden and increase to 1.0 for visible
          duration: Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "HOMEBREW",
                style: TextStyle(
                  color: Colors.white, // Set your branding text color
                  fontSize: 48, // Adjust text size
                  fontWeight: FontWeight.w400, // Font weight: regular
                  fontFamily: 'Norwester', // Use the Norwester font
                ),
              ),
              Text(
                "Great Coffee at Home",
                style: TextStyle(
                  color: Colors.white, // Set your branding text color
                  fontSize: 18, // Adjust text size
                  fontWeight: FontWeight.w400, // Font weight: regular
                  fontFamily: 'Kollektif', // Use the Kollektif font
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}