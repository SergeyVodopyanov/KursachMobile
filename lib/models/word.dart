class Word {
  String word; // Убрали final
  String translation; // Убрали final
  bool isLearned;
  String category;

  Word({
    required this.word,
    required this.translation,
    this.isLearned = false,
    this.category = 'Без категории',
  });
}