import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// this is not a sin
// void main() {
//   runApp(MyApp());
// }

// likewise this
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Endless wordList Generator',
      // for a dark theme 
      // theme: ThemeData.dark(),

      // for a light theme
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      home: RandomWords(),
      );
  }
}

class RandomWordsState extends State<RandomWords> {

  final List<WordPair> _suggestions = <WordPair> [];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

  // final _suggestions = <WordPair>[];
  // final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text (
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        title: Text('Endless wordList Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body : _buildSuggestions(),
    );
  }

  // 
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> titles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          final List<Widget> divided = ListTile
          .divideTiles(
            context: context, 
            tiles: titles,
            )
            .toList();

            return Scaffold(appBar: AppBar(
              title: Text('Randomize saved wordLists'),
            ),
              body: ListView(children: divided),
          );
        }
      )
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}