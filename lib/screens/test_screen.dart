import 'package:flutter/material.dart';
import '../services/word_service.dart';

class TestScreen extends StatefulWidget {
  final WordService wordService;

  TestScreen({required this.wordService});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentIndex = 0;
  int correctAnswers = 0;
  int totalQuestions = 0;
  bool isTestFinished = false;

  // Массив из 200 случайных русских слов
  final List<String> russianWords = [
    'дом', 'кот', 'солнце', 'вода', 'дерево', 'книга', 'город', 'машина', 'цветок', 'друг',
    'школа', 'работа', 'время', 'деньги', 'жизнь', 'мир', 'любовь', 'счастье', 'музыка', 'искусство',
    'путешествие', 'мечта', 'звезда', 'океан', 'гора', 'лес', 'птица', 'рыба', 'собака', 'кофе',
    // Укороченный список для примера
  ];

  void _showNextWord() {
    if (totalQuestions >= 15) {
      setState(() {
        isTestFinished = true;
      });
      return;
    }

    setState(() {
      currentIndex = (currentIndex + 1) % widget.wordService.getWords().length;
      totalQuestions++;
    });
  }

  void _checkAnswer(String selectedOption) {
    if (selectedOption == widget.wordService.getWords()[currentIndex].translation) {
      correctAnswers++;
    }
    _showNextWord();
  }

  List<String> _generateOptions() {
    final correctAnswer = widget.wordService.getWords()[currentIndex].translation;
    final options = [correctAnswer];

    // Добавляем два случайных слова из массива русских слов
    while (options.length < 3) {
      final randomWord = russianWords[(DateTime.now().millisecondsSinceEpoch % russianWords.length)];
      if (!options.contains(randomWord)) {
        options.add(randomWord);
      }
    }

    options.shuffle(); // Перемешиваем варианты
    return options;
  }

  @override
  Widget build(BuildContext context) {
    if (isTestFinished) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Тестирование завершено'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Правильных ответов: $correctAnswers из 15',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Вернуться на главный экран'),
              ),
            ],
          ),
        ),
      );
    }

    final word = widget.wordService.getWords()[currentIndex];
    final options = _generateOptions();

    return Scaffold(
      appBar: AppBar(
        title: Text('Тестирование'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              word.word,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(200, 40), // Устанавливаем минимальный размер кнопок
                  ),
                  onPressed: () => _checkAnswer(option),
                  child: Text(
                    option,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            Text(
              'Вопрос ${totalQuestions + 1} из 15',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Text(
              'Правильных ответов: $correctAnswers',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
