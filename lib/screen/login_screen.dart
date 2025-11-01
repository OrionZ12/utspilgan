import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToQuestion() {
    final name = _controller.text.trim();
    context.go(AppRoutes.question, extra: {'playerName': name});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191970),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Nama'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _goToQuestion, child: const Text('Masuk')),
            ],
          ),
        ),
      ),
    );
  }
}
