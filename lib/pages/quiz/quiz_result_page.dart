import 'package:flutter/material.dart';
import '../../models/QuizResult.dart';
import 'recommendations_page.dart';
/// Page des résultats du quiz
/// - Affiche score et niveau
/// - Redirige vers les recommandations
class QuizResultPage extends StatelessWidget {
  final QuizResult result;
  const QuizResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Résultat du Quiz")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Score : ${result.totalScore}/20",
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Niveau : ${result.level}", style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecommendationsPage(level: result.level),
                  ),
                );
              },
              child: const Text("Voir les recommandations"),
            ),
          ],
        ),
      ),
    );
  }
}
