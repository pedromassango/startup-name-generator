import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Welcome to Flutter',
     home: new RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>{
  // A list of words
  final List<WordPair> _suggestions = <WordPair>[];
  // Row text style
  final TextStyle _bigText = const TextStyle(fontSize: 16.0);

  // Build a row style, and set the word
  Widget _buildRow(WordPair pair){
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _bigText,
      ),
    );
  }

  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i){
        if(i.isOdd){
          return new Divider();
        }
        final int index  = i ~/ 2;
        // reach the end of listView, genera more words
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //final WordPair wordPair = new WordPair.random();
    //return (new Text(wordPair.asPascalCase));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'), // Widget title [app title]
      ),
      body: _buildSuggestions(),
    );
  }
}

// To persist data state
class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => new RandomWordsState();
}