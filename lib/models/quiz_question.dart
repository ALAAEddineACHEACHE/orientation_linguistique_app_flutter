class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final int points;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.points = 2,
  });
}
