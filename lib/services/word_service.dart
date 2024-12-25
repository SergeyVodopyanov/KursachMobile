import '../models/word.dart'; // Добавьте эту строку

class WordService {
  List<Word> words = [];

  void addWord(String word, String translation) {
    words.add(Word(word: word, translation: translation));
  }

  void markAsLearned(int index) {
    words[index].isLearned = true;
  }

  void deleteWord(int index) {
    words.removeAt(index); // Удаляем слово по индексу
  }

  List<Word> getWords() {
    return words;
  }
}