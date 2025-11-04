import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/routes.dart';

class EndingScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int totalTime;

  const EndingScreen({
    Key? key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.totalTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double score = 0;
    if (totalTime > 0) {
      score = correctAnswers * (1 / totalTime) * 1000;
    }

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF191970),
      body: SafeArea(
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              final imageSize = isWide ? 200.0 : screenWidth * 0.4;
              final fontTitle = isWide ? 30.0 : 26.0;
              final fontBody = isWide ? 22.0 : 18.0;
              final buttonWidth = isWide ? 300.0 : screenWidth * 0.7;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SELAMAT QUIZ TELAH BERAKHIR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontTitle,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 40),

                    //img
                    ClipOval(
                      child: Container(
                        width: imageSize,
                        height: imageSize,
                        color: Colors.white.withOpacity(0.1),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'lib/aset/img/Jean.jpg',
                            width: imageSize,
                            height: imageSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Text(
                      "Anda menjawab $correctAnswers/$totalQuestions soal dengan benar",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontBody,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Skor Akhir = ${score.toStringAsFixed(2)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isWide ? 24 : 20,
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 50),

                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: buttonWidth),
                      child: ElevatedButton(
                        onPressed: () => context.go(AppRoutes.login),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6495ED),
                          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          "Kembali ke Awal",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
