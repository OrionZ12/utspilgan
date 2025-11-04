import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:utspilgan/screen/login_screen.dart';
import 'package:utspilgan/screen/question_screen.dart';
import 'package:utspilgan/screen/splash_screen.dart';
import 'package:utspilgan/screen/ending_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String question = '/question';
  static const String ending = '/ending';
}

GoRouter createRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.question,
        name: 'question',
        builder: (context, state) => const QuestionScreen(),
      ),

      GoRoute(
        path: AppRoutes.ending,
        name: 'ending',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return EndingScreen(
            correctAnswers: args['benar'],
            totalQuestions: args['total'],
            totalTime: args['time'],
          );
        },
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('Path: ${state.uri.path}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.splash),
              child: const Text('Go to Splash'),
            ),
          ],
        ),
      ),
    ),
  );
}
