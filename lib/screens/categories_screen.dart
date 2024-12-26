import 'package:flutter/material.dart';
import '../services/word_service.dart';

class CategoriesScreen extends StatefulWidget {
  final WordService wordService;

  CategoriesScreen({required this.wordService});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController categoryController = TextEditingController();

  void _addCategory() {
    if (categoryController.text.isNotEmpty) {
      setState(() {
        widget.wordService.addCategory(categoryController.text);
        categoryController.clear();
      });
    }
  }

  void _deleteCategory(String name) {
    setState(() {
      widget.wordService.deleteCategory(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Категории'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                labelText: 'Новая категория',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addCategory,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.wordService.categories.length,
                itemBuilder: (context, index) {
                  final category = widget.wordService.categories[index];
                  return ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteCategory(category.name),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}