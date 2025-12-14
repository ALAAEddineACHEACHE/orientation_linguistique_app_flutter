import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import '../models/quiz_result.dart';
/// Provider responsable de la logique métier du quiz
/// - Gestion de la navigation entre questions
/// - Enregistrement des réponses
/// - Calcul du score final
/// - Détermination du niveau de l’étudiant
// Distribuer une instance de modèle à l’arbre de widgets 
class QuizProvider extends ChangeNotifier {
    /// Index de la question courante
  int index = 0;
    /// Score total obtenu par l’étudiant
  int score = 0;
  /// Liste des réponses sélectionnées par l’utilisateur
  /// Chaque position correspond à l’index d’une question
  List<int?> answers = List.filled(10, null);
  /// Liste statique des questions du quiz
  /// Réparties en trois catégories :
  /// - Spring Boot
  /// - English
  /// - Français
  final List<QuizQuestion> questions = [
    // ---------------- SPRING BOOT ----------------
    QuizQuestion(
      question: "Quel fichier configure principalement une application Spring Boot ?",
      options: ["config.yml", "application.properties", "boot.config"],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: "Quelle annotation démarre une application Spring Boot ?",
      options: ["@SpringBootApplication", "@EnableBoot", "@RunApp"],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: "Quel composant gère l’accès aux données en Spring Boot ?",
      options: ["Spring Data JPA", "Spring UI", "Spring Views"],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: "Que permet l’annotation @RestController ?",
      options: [
        "Créer des vues HTML",
        "Exposer des endpoints REST",
        "Gérer la sécurité"
      ],
      correctIndex: 1,
    ),

    // ---------------- ENGLISH ----------------
    QuizQuestion(
      question: "Choose the correct word: “I ___ to the gym every day.”",
      options: ["go", "goes", "am going"],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: "What is the synonym of “improve”?",
      options: ["worsen", "enhance", "ignore"],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: "Choose the correct sentence:",
      options: [
        "She don’t like coffee.",
        "She doesn’t like coffee.",
        "She no like coffee."
      ],
      correctIndex: 1,
    ),

    // ---------------- FRANÇAIS ----------------
    QuizQuestion(
      question: "Conjugue correctement : « Ils ___ au travail. »",
      options: ["vont", "vas", "allez"],
      correctIndex: 0,
    ),
    QuizQuestion(
      question: "Quel est le synonyme de « joyeux » ?",
      options: ["triste", "heureux", "fâché"],
      correctIndex: 1,
    ),
    QuizQuestion(
      question: "Choisis la phrase correcte :",
      options: [
        "Il faut que tu viens.",
        "Il faut que tu viennes.",
        "Il faut que tu vient."
      ],
      correctIndex: 1,
    ),
  ];

  // ------------------ Sélection réponse ------------------
  
  /// Enregistre la réponse choisie par l’étudiant
  /// puis notifie l’interface pour mise à jour immédiate
  void selectAnswer(int? value) {
    answers[index] = value;
    notifyListeners();
  }

  // ------------------ Aller à la question suivante ------------------
  void nextQuestion() {
    if (index < questions.length - 1) {
      index++;
      notifyListeners();
    }
  }

  // ------------------ Calcul du score ------------------
  QuizResult calculateScore() {
    score = 0;

    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == questions[i].correctIndex) {
        score += questions[i].points; // 2 points par question
      }
    }

    String level = "Débutant";

    if (score >= 16) level = "Avancé";
    else if (score >= 10) level = "Intermédiaire";

    return QuizResult(totalScore: score, level: level);
  }

  // ------------------ Reset quiz Réinitialise le quiz afin de permettre à l’étudiant de recommencer l’évaluation ------------------
  void resetQuiz() {
    index = 0;
    score = 0;
    answers = List.filled(10, null);
    notifyListeners();
  }
}
