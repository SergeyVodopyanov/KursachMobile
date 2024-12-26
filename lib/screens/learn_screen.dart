import 'package:flutter/material.dart';
import '../services/word_service.dart';

class LearnScreen extends StatefulWidget {
  final WordService wordService;

  LearnScreen({required this.wordService});

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final TextEditingController wordController = TextEditingController();
  final TextEditingController translationController = TextEditingController();
  String selectedCategory = 'Без категории';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить слово'),
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
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: widget.wordService.getCategories().map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.wordService.addWord(
                  wordController.text,
                  translationController.text,
                  category: selectedCategory,
                );
                Navigator.pop(context);
              },
              child: Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}