import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Navigate to the home screen when the image is tapped
          Navigator.of(context).pushReplacementNamed('/home');
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              // Replace with your image asset path
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
