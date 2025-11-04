import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../config/routes.dart';
import '../question/question_list.dart';
import '../widget/opsiopsi.dart';
import '../provider/name_saver.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late final String playerName;
  int currentQuestionIndex = 0;
  int benar = 0;

  final List<int> _usedQuestionIndexes = [];
  final Random _random = Random();

  int elapsedSeconds = 0;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = ModalRoute.of(context)?.settings.arguments;
    final routeExtra = (extra is Map) ? extra : {};
    playerName = (routeExtra['playerName'] as String?) ?? 'Guest';
    _startTimer();
    _generateNewQuestion();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          elapsedSeconds++;
        });
      }
    });
  }

  void _generateNewQuestion() {
    if (_usedQuestionIndexes.length >= questionList.length) {
      _showQuizEndDialog();
      return;
    }

    int newIndex;
    do {
      newIndex = _random.nextInt(questionList.length);
    } while (_usedQuestionIndexes.contains(newIndex));

    if (mounted) {
      setState(() {
        _usedQuestionIndexes.add(newIndex);
        currentQuestionIndex = newIndex;
      });
    }
  }

  void _onOptionSelected(String selectedOption) {
    final correctAnswer = questionList[currentQuestionIndex]['answer'] as String;

    if (selectedOption == correctAnswer) {
      benar++;
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _generateNewQuestion();
    });
  }

  void _showQuizEndDialog() {
    _timer?.cancel();
    if (!mounted) return;

    context.go(
      AppRoutes.ending,
      extra: {
        'benar': benar,
        'total': questionList.length,
        'time': elapsedSeconds,
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    final q = questionList.isNotEmpty
        ? questionList[currentQuestionIndex]
        : {'question': 'No question', 'options': ['-', '-', '-', '-']};

    final options = List<String>.from(q['options'] as List);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF191970),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6495ED),
        title: const Text(
          'Kwizly',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Consumer<NameSaver>(
                builder: (context, nameSaver, _) => Text(
                  nameSaver.name.isNotEmpty ? nameSaver.name : playerName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white24, width: 1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.timer, color: Colors.white, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  _formatTime(elapsedSeconds),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.05),

                        // Box soal (responsif)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD6E0F0),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 10,
                                spreadRadius: 5,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            height: screenHeight * 0.18, // adaptif tinggi soal
                            child: Center(
                              child: AutoSizeText(
                                q['question'] as String,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 3,
                                minFontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: screenHeight * 0.08),

                        // Box opsi (responsif)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                opsi(
                                  label: options[0],
                                  color: const Color(0xFFDC143C),
                                  onTap: () => _onOptionSelected(options[0]),
                                ),
                                opsi(
                                  label: options[1],
                                  color: const Color(0xFF3CB371),
                                  onTap: () => _onOptionSelected(options[1]),
                                ),
                                opsi(
                                  label: options[2],
                                  color: Colors.yellow[700]!,
                                  onTap: () => _onOptionSelected(options[2]),
                                ),
                                opsi(
                                  label: options[3],
                                  color: Colors.blue,
                                  onTap: () => _onOptionSelected(options[3]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
