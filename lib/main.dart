import 'package:flutter/material.dart';
import 'onboarding.dart';

void main() {
  runApp(CarNestApp());
}

class CarNestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica',
        primaryColor: Colors.black,
      ),
      home: OnboardingScreen(),
    );
  }
}
