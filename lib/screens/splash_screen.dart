import 'package:flutter/material.dart'; // Importing Flutter's material design library
import 'package:workshop/screens/home_screen.dart'; // Importing the HomeScreen widget

// SplashScreen widget displays a splash screen with a logo for a few seconds before navigating to HomeScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// State class for SplashScreen to manage its state and lifecycle
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds, then navigate to the HomeScreen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        // Replaces the current screen with HomeScreen so that the splash screen
        // is not accessible when the back button is pressed
        MaterialPageRoute(
          builder: (context) => const HomeScreen(), // Navigates to HomeScreen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A Scaffold provides the basic structure for a screen
      body: Center(
        // Center widget centers its child in the available space
        child: Image.asset("assets/images/logo.png"), // Displays the app logo
      ),
    );
  }
}
