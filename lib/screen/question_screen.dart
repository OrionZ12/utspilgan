import 'package:flutter/material.dart';
import '../question/question_list.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late final String playerName;
  int currentQuestionIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = ModalRoute.of(context)?.settings.arguments ?? (ModalRoute.of(context)?.settings.arguments ?? {});
    // try both common ways (GoRouter uses state.extra when using go(..., extra: {...}))
    final routeExtra = (extra is Map) ? extra : {};
    playerName = (routeExtra['playerName'] as String?) ?? 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    final q = questionList.isNotEmpty ? questionList[currentQuestionIndex] : {'question': 'No question', 'options': ['-','-','-','-']};
    final options = List<String>.from(q['options'] as List);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kwizly'),
        actions: [Padding(padding: const EdgeInsets.all(8.0), child: Center(child: Text(playerName)))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Text(q['question'] as String, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _option(options[0], Colors.red),
                  _option(options[1], Colors.green),
                  _option(options[2], Colors.yellow[700]!),
                  _option(options[3], Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _option(String label, Color color) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}
