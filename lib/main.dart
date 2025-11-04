import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config//routes.dart';
import 'package:provider/provider.dart';
import 'provider/name_saver.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NameSaver(),
      child: const MyApp(),
    ),
  );
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
