import 'package:flutter/material.dart';
import '../services/word_service.dart';
import 'learn_screen.dart';
import 'test_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WordService wordService = WordService();

  void _refreshWords() {
    setState(() {});
  }

  void _deleteWord(int index) {
    wordService.deleteWord(index);
    _refreshWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Изучение слов'),
      ),
      body: ListView.builder(
        itemCount: wordService.getWords().length,
        itemBuilder: (context, index) {
          final word = wordService.getWords()[index];
          return ListTile(
            title: Text(word.word),
            subtitle: Text(word.translation),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteWord(index),
                ),
                Icon(
                  word.isLearned ? Icons.check : Icons.close,
                  color: word.isLearned ? Colors.green : Colors.red,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LearnScreen(wordService: wordService)),
              );
              _refreshWords();
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16), // Отступ между кнопками
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestScreen(wordService: wordService)),
              );
            },
            child: Icon(Icons.quiz), // Иконка для тестирования
          ),
        ],
      ),
    );
  }
}