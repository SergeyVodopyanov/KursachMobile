class Word {
  final String word;
  final String translation;
  bool isLearned;

  Word({
    required this.word,
    required this.translation,
    this.isLearned = false,
  });
}