import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:vocab_app/pages/tfquiz_starting_page.dart';

import "../card/learn_page.dart";
import "../pages/quiz_starting_page.dart";
import "../helpers/setcolors_helper.dart";
import "../game/game.dart";

class OptionButton extends StatefulWidget{
  OptionButton({
    @required this.option,
    @required this.difficulty,
    @required this.level,
    @required this.prefs
  });

  final String option;
  final String difficulty;
  final String level;
  SharedPreferences prefs;

  @override
  State createState ()=> new OptionButtonState();
}

class OptionButtonState extends State<OptionButton>{

  Color _getButtonColor(){
    String theme = widget.prefs.getString("theme");
    Color rst = getColor(theme, widget.level);
    return rst;
  }

  void _pageRedirect(){
//    if(widget.option == 'study') Navigator.of(context).push(new MaterialPageRoute(
//        builder: (BuildContext context) => new LearnPage(difficulty: widget.difficulty, level: widget.level, prefs: widget.prefs)));
  if (widget.option == 'study') Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new LearnCards(prefs: widget.prefs, difficulty: widget.difficulty, level: widget.level, option: '0')));
    else Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new TFQuizStartPage(level: widget.level, difficulty: widget.difficulty))); //new QuizPage()
  }

  @override
  Widget build(BuildContext context){
    return new Material(
        color: _getButtonColor(),//ternary operator
        elevation: 6.0,
        borderRadius: BorderRadius.circular(8.0),
        child: SizedBox(
          height: 160.0,
          width: 260.0,
          child: new InkWell(
            onTap: () => _pageRedirect(),
            child: new Center(
              child: new Container(
                child: new Text(widget.option,
                    style: new TextStyle(color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      );
  }
}