class Word {
  String word; // Убрали final
  String translation; // Убрали final
  bool isLearned;

  Word({
    required this.word,
    required this.translation,
    this.isLearned = false,
  });
}