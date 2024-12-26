import 'package:flutter/material.dart';
import '../services/word_service.dart';

class StatsScreen extends StatelessWidget {
  final WordService wordService;

  StatsScreen({required this.wordService});

  @override
  Widget build(BuildContext context) {
    final totalWords = wordService.getWords().length;
    final learnedWords = wordService.getWords().where((word) => word.isLearned).length;
    final remainingWords = totalWords - learnedWords;

    return Scaffold(
      appBar: AppBar(
        title: Text('Статистика'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StatisticCard(
              title: 'Всего слов',
              value: totalWords.toString(),
              icon: Icons.list,
            ),
            SizedBox(height: 20),
            StatisticCard(
              title: 'Изучено слов',
              value: learnedWords.toString(),
              icon: Icons.check_circle,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            StatisticCard(
              title: 'Осталось слов',
              value: remainingWords.toString(),
              icon: Icons.hourglass_empty,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  StatisticCard({
    required this.title,
    required this.value,
    required this.icon,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: TextStyle(fontSize: 24, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}