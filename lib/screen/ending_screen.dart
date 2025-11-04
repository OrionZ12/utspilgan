import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/routes.dart';

class EndingScreen extends StatelessWidget {
  final int correctAnswers; // Z = jumlah benar
  final int totalQuestions; // Y = total soal (misal 10)
  final int totalTime; // t = waktu total (dalam detik)
  final String imagePath; // path gambar

  const EndingScreen({
    Key? key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.totalTime,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Rumus skor akhir: Z * (1/t) * 1000
    double score = 0;
    if (totalTime > 0) {
      score = correctAnswers * (1 / totalTime) * 1000;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF191970), // sama seperti QuestionScreen
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SELAMAT QUIZ TELAH BERAKHIR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 40),

                // Gambar dengan frame bulat
                ClipOval(
                  child: Container(
                    width: 160,
                    height: 160,
                    color: Colors.white.withOpacity(0.1),
                    child: FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'lib/aset/img/Jean.jpg',
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Teks jumlah benar
                Text(
                  "Anda berhasil menjawab $correctAnswers/$totalQuestions soal dengan benar",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                // Skor akhir
                Text(
                  "Skor Akhir = ${score.toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6495ED),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Kembali ke Awal",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
