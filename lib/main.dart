import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      title: 'Welcome to Flutter',
     theme: new ThemeData(
       primaryColor: Colors.white
     ),
     home: new RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>{
  // A list of words
  final List<WordPair> _suggestions = <WordPair>[];
  // Store favoried words
  final Set<WordPair> _saved = new Set<WordPair>();
  // Row text style
  final TextStyle _bigText = const TextStyle(fontSize: 18.0);

  // Build a row style, and set the word.
  // This represent a single row item
  Widget _buildRow(WordPair pair){
    // if this item is in _saved words, it was favorited.
    final bool alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _bigText,
      ),
      trailing: new Icon( // favorite icon
        alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
      ),
      onTap: () { // Row click item
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

  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context){
          final Iterable<ListTile> titles = _saved.map(
              (WordPair pair){
                return new ListTile(
                  title: new Text(
                    pair.asPascalCase,
                    style: _bigText,
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

          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final WordPair wordPair = new WordPair.random();
    //return (new Text(wordPair.asPascalCase));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'), // Widget title [app title]
      actions: <Widget>[
        new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
      ],
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