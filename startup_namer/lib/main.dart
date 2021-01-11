// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hoee', // recent app (in android) switcher (in ios)

      theme: ThemeData(
        primaryColor: Colors.red[200],
        accentColor: Colors.purple[300],
        scaffoldBackgroundColor: Colors.amber[50],
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <Station>[
    Station("충남대학교", 1),
    Station("카이스트", 2),
    Station("서울대학교", 3),
    Station("Yonsei", 4),
    Station("Korea", 5),
    Station("Pohang", 6),
    Station("Inha", 7)
  ];
  final _saved = Set<Station>();
  final _biggerFont = TextStyle(fontSize: 22.0, color: Colors.black);

  void _clickMark(int stationNum) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_suggestions[stationNum - 1].name),
            ),
            body: Container(
                alignment: Alignment.center,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.asset(
                          "image/" + stationNum.toString() + ".png",
                          width: 320,
                          height: 240,
                        )),
                    Container(
                        color: Colors.white,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Column(children: [
                                  Icon(Icons.school,
                                      color: Colors.black, size: 40.0),
                                  Container(
                                    child:
                                        Text(_suggestions[stationNum - 1].name),
                                  ),
                                ]),
                              ),
                              Expanded(
                                child: Column(children: [
                                  Icon(Icons.eco,
                                      color: Colors.lime, size: 40.0),
                                  Container(
                                    child: Text("Echo"),
                                  ),
                                ]),
                              ),
                              Expanded(
                                child: Column(children: [
                                  Icon(Icons.hd,
                                      color: Colors.purple, size: 40.0),
                                  Container(
                                    child: Text("HD"),
                                  ),
                                ]),
                              ),
                            ]))
                  ],
                )),
          );
        },
      ),
    );
  }

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

  Widget _images(Station station) {
    return Column(children: <Widget>[
      Expanded(
          child: GestureDetector(
        onTap: () {
          _clickMark(station.number);
        },
        child: Image.asset("image/" + station.number.toString() + ".png"),
      )),
      Expanded(
          child: Text(station.name,
              style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                        const Offset(0, 20),
                        const Offset(150, 20),
                        <Color>[Colors.red, Colors.blue])))),
    ]);
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
        itemCount: _suggestions.length * 2,
        itemBuilder: /*1*/ (context, i) {
          if (i.isEven) return Divider(); /*2*/
          final index = i ~/ 2; /*3*/
          // if (index >= _suggestions.length) {
          //   _suggestions.add(Station("hi", 1)); /*4*/
          // }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _swiperTest() {
    return Swiper(
      itemBuilder: (BuildContext context, int i) {
        return _images(_suggestions[i]);
      },
      itemCount: 3,
      viewportFraction: 0.6,
      scale: 0.4,
      pagination: SwiperPagination(),
      control: SwiperControl(),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Colleges'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset("image/chungnam.png"),
        onPressed: () {
          _pushSaved();
        },
        backgroundColor: Colors.white,
      ),
      body: _swiperTest(),
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
