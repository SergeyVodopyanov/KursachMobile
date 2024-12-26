import '../models/word.dart';
import '../models/category.dart';

class WordService {
  List<Word> words = [];
  List<Category> categories = [Category(name: 'Без категории')];

  void addWord(String word, String translation, {String category = 'Без категории'}) {
    words.add(Word(word: word, translation: translation, category: category));
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

  List<String> getCategories() {
    return categories.map((category) => category.name).toList();
  }

  void addCategory(String name) {
    categories.add(Category(name: name));
  }

  void deleteCategory(String name) {
    categories.removeWhere((category) => category.name == name);
  }
}