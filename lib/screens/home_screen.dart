import 'package:flutter/material.dart';
import '../services/word_service.dart';
import '../models/word.dart';
import 'learn_screen.dart';
import 'test_screen.dart';
import 'edit_screen.dart';
import 'stats_screen.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WordService wordService = WordService();
  String _searchQuery = '';
  String _selectedCategory = 'Все категории';

  void _refreshWords() {
    setState(() {});
  }

  void _deleteWord(int index) {
    wordService.deleteWord(index);
    _refreshWords();
  }

  void _editWord(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          wordService: wordService,
          index: index,
        ),
      ),
    );
    _refreshWords();
  }

  void _toggleLearnedStatus(int index) {
    setState(() {
      wordService.getWords()[index].isLearned = !wordService.getWords()[index].isLearned;
    });
  }

  List<Word> getFilteredWords() {
    List<Word> filteredWords = wordService.getWords().where((word) =>
        word.word.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        word.translation.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    if (_selectedCategory != 'Все категории') {
      filteredWords = filteredWords.where((word) => word.category == _selectedCategory).toList();
    }

    return filteredWords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Изучение слов'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoriesScreen(wordService: wordService),
                ),
              );
            },
            icon: Icon(Icons.category),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatsScreen(wordService: wordService),
                ),
              );
            },
            icon: Icon(Icons.bar_chart),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Поиск...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  items: ['Все категории'].followedBy(wordService.getCategories()).map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  isExpanded: true,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFilteredWords().length,
              itemBuilder: (context, index) {
                final word = getFilteredWords()[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  elevation: 4,
                  child: ListTile(
                    title: Text(word.word, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(word.translation),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _toggleLearnedStatus(index),
                          icon: Icon(
                            word.isLearned ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: word.isLearned ? Colors.green : Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _editWord(index),
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () => _deleteWord(index),
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'learnButton',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LearnScreen(wordService: wordService)),
              );
              _refreshWords();
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'testButton',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestScreen(wordService: wordService)),
              );
            },
            child: Icon(Icons.quiz),
          ),
        ],
      ),
    );
  }
}