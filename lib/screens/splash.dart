import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/images/Animation - 1719381956762.json'),
          const SizedBox(
              height: 20), // Add space between the animation and text
          const Text(
            'E-commerce App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      nextScreen: user != null ? const MainHomePage() : const LoginUI(),
      backgroundColor: Colors.white,
      splashIconSize:
          double.infinity, // Ensure splash screen covers the entire screen
      duration: 2000, // Duration in milliseconds
    );
  }
}
