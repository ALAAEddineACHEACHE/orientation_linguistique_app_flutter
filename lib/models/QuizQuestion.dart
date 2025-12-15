/// Modèle représentant une question du quiz
class QuizQuestion {
  final String question; // Énoncé de la question
  final List<String> options; // Choix possibles
  final int correctIndex; // Index de la bonne réponse
  final int points; // Nombre de points attribués

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.points = 2,  // Valeur par défaut
  });
}
