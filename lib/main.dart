import 'package:flutter/material.dart';
import 'package:vocab_app/pages/home_page.dart';
import 'package:vocab_app/pages/search_page.dart';

import 'pages/quiz_starting_page.dart';
import 'pages/level_page.dart';
import 'pages/color_palette.dart';
import 'UI/palette_component.dart';
import 'pages/intro_page.dart';
import 'game/game.dart';
import 'package:vocab_app/UI/heartbeat.dart';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      //home: new IntroPage(),
      //home: new GamePlay(title: "Opacity")
      //home: new HeartBeat()
      //home: new LandingPage(),
      //home: HomePage(),
      home: HomePage(),
      theme: ThemeData(fontFamily: 'Petita'),
      //home: new PageViewPage()
      //home: new LevelPage(difficulty: null, level: false)

      //home: new ColorStripe(color: Colors.red)
    );
  }
}