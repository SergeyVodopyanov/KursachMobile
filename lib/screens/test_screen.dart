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
    'чай', 'хлеб', 'молоко', 'яблоко', 'банан', 'апельсин', 'помидор', 'картошка', 'морковь', 'лук',
    'сахар', 'соль', 'перец', 'масло', 'сыр', 'мясо', 'рыба', 'суп', 'салат', 'десерт',
    'завтрак', 'обед', 'ужин', 'ночь', 'утро', 'вечер', 'зима', 'весна', 'лето', 'осень',
    'погода', 'дождь', 'снег', 'ветер', 'туча', 'радуга', 'гроза', 'молния', 'температура', 'холод',
    'тепло', 'жарко', 'прохладно', 'свет', 'тьма', 'огонь', 'вода', 'воздух', 'земля', 'камень',
    'песок', 'глина', 'металл', 'золото', 'серебро', 'бронза', 'железо', 'сталь', 'алмаз', 'рубин',
    'изумруд', 'сапфир', 'платина', 'нефть', 'газ', 'уголь', 'дерево', 'бумага', 'стекло', 'пластик',
    'резина', 'кожа', 'ткань', 'шерсть', 'шелк', 'хлопок', 'лен', 'шёлк', 'мех', 'пух',
    'перо', 'кость', 'рог', 'клык', 'кожа', 'волос', 'ногть', 'кровь', 'сердце', 'легкое',
    'печень', 'желудок', 'кишечник', 'мозг', 'нерв', 'мышца', 'кость', 'сустав', 'кожа', 'глаз',
    'ухо', 'нос', 'рот', 'зуб', 'язык', 'губа', 'щека', 'лоб', 'подбородок', 'шея',
    'плечо', 'рука', 'локоть', 'запястье', 'ладонь', 'палец', 'ногть', 'грудь', 'живот', 'спина',
    'поясница', 'бедро', 'колено', 'нога', 'ступня', 'пятка', 'палец', 'волос', 'кожа', 'кость',
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
      final randomWord = russianWords[(DateTime.now().millisecondsSinceEpoch % 200)];
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
              Text('Правильных ответов: $correctAnswers из 15', style: TextStyle(fontSize: 24)),
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
      body: Column(
        children: [
          Text(word.word, style: TextStyle(fontSize: 24)),
          ...options.map((option) {
            return ElevatedButton(
              onPressed: () => _checkAnswer(option),
              child: Text(option),
            );
          }).toList(),
          Text('Вопрос ${totalQuestions + 1} из 15'),
          Text('Правильных ответов: $correctAnswers'),
        ],
      ),
    );
  }
}