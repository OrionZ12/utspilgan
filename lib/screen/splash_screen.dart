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
    return const Scaffold(
      backgroundColor: Color(0xFF191970),
      body: Center(
        child: Text(
          'Kwizly',
          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
