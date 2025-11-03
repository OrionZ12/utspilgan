import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config//routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = createRouter();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Kwizly',
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'ComicRelief',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6A0DAD)),
        useMaterial3: true,
      ),
    );
  }
}
