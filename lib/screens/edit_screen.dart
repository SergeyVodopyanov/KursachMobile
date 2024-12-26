import 'package:flutter/material.dart';
import '../services/word_service.dart';

class EditScreen extends StatefulWidget {
  final WordService wordService;
  final int index;

  EditScreen({required this.wordService, required this.index});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController translationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final word = widget.wordService.getWords()[widget.index];
    wordController.text = word.word;
    translationController.text = word.translation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать слово'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: wordController,
              decoration: InputDecoration(labelText: 'Слово'),
            ),
            TextField(
              controller: translationController,
              decoration: InputDecoration(labelText: 'Перевод'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.wordService.getWords()[widget.index].word = wordController.text;
                widget.wordService.getWords()[widget.index].translation = translationController.text;
                Navigator.pop(context);
              },
              child: Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}