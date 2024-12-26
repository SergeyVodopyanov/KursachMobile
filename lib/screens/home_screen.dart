import 'package:flutter/material.dart';
import '../services/word_service.dart';
import 'learn_screen.dart';
import 'test_screen.dart';
import 'edit_screen.dart';
import 'stats_screen.dart';

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
                  builder: (context) => StatsScreen(wordService: wordService),
                ),
              );
            },
            icon: Icon(Icons.bar_chart),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: wordService.getWords().length,
        itemBuilder: (context, index) {
          final word = wordService.getWords()[index];
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