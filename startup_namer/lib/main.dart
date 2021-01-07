// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hoee', // recent app (in android) switcher (in ios)
      theme: ThemeData(
        primaryColor: Colors.amber,
        accentColor: Colors.purpleAccent,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <Station>[
    Station("daejeon", 1),
    Station("pohang", 2),
    Station("seoul", 3),
    Station("Sejong", 4),
    Station("daegu", 5),
    Station("Busan", 6),
    Station("Hi", 7)
  ];
  final _saved = Set<Station>();
  final _biggerFont = TextStyle(fontSize: 22.0, color: Colors.blue[400]);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (Station pair) {
              return ListTile(
                title: Text(
                  pair.name,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('favorite menu'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildRow(Station pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.name,
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

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _suggestions.length,
        itemBuilder: /*1*/ (context, i) {
          // if (i.isOdd) return Divider(); /*2*/
          final index = i; /*3*/
          // if (index >= _suggestions.length) {
          //   _suggestions.add(Station("hi", 1)); /*4*/
          // }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Random Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class Station {
  String name;
  int number;
  Station(this.name, this.number);
}
