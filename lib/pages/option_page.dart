import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:vocab_app/UI/bottom_appbar.dart';

import "package:vocab_app/navbuttons/option_button.dart";

class OptionPage extends StatelessWidget{
  OptionPage({
    @required this.difficulty,
    @required this.level,
    @required this.prefs,
    @required this.buttonColor,
  });

  final String difficulty;
  final String level;
  final SharedPreferences prefs;
  final Color buttonColor;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: ScaffoldBottomAppBar(
        parentContext: context,
        buttonColor: buttonColor,
        prefs: prefs,
        curPage: 'level',
      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new OptionButton(option: "study", difficulty: difficulty, level: level, prefs: prefs),
            new Divider(height: 80.0),
            new OptionButton(option: "quiz", difficulty: difficulty, level: level, prefs: prefs)
          ],
        ),
      );
  }
}