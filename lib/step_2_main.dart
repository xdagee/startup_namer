import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Namer',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Startup Namer'),
        ),
        body: Center(
          child: Text(wordPair.asPascalCase),
        ),
      ),
      
    );
  }
}