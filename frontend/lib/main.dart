import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/signup/signup_screen.dart';
import 'package:frontend/screens/homepage/HomePage.dart';
import 'package:frontend/screens/menstrual_cycle_tracking/tracking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Tracking(),
      home: SignupScreen(),
    );
  }
}
