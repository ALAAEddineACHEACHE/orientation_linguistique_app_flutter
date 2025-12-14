 /// Calcule le score total et détermine le niveau de l’étudiant
  /// - Débutant
  /// - Intermédiaire
  /// - Avancé
class QuizResult {
  final int totalScore;
  final String level; // débutant - intermédiaire - avancé

  QuizResult({required this.totalScore, required this.level});
}
