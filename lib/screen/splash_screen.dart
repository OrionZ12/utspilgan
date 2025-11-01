import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) context.go(AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF191970),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.35,
              height: screenWidth * 0.35,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icon.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'QuizMaster',
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
