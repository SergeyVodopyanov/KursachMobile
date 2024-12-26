import '../models/word.dart';

class WordService {
  List<Word> words = [];

  void addWord(String word, String translation) {
    words.add(Word(word: word, translation: translation));
  }

  void markAsLearned(int index) {
    words[index].isLearned = true;
  }

  void deleteWord(int index) {
    words.removeAt(index);
  }

  List<Word> getWords() {
    return words;
  }
}