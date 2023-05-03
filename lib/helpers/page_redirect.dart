import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_app/UI/exit_alert.dart';
import 'package:vocab_app/model/vocab.dart';
import 'package:vocab_app/pages/TFQuizPage.dart';
import 'package:vocab_app/pages/color_palette.dart';
import 'package:vocab_app/pages/home_page.dart';
import 'package:vocab_app/pages/search_page.dart';
import 'package:vocab_app/pages/single_word.dart';
import 'package:vocab_app/utils/tf_quiz.dart';


import '../pages/option_page.dart';
import '../pages/level_page.dart';
import '../pages/quiz_page.dart';
import '../card/learn_page.dart';
import '../utils/quiz.dart';


void pageRedirect({String difficulty, String level, bool levelCheck, BuildContext context,
  SharedPreferences prefs, Color buttonColor,}){
  print("I am here");
  if(levelCheck == true) Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new OptionPage(difficulty: difficulty, level: level, prefs: prefs, buttonColor: buttonColor,)));
  else Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => new LevelPage(difficulty: difficulty, levelCheck: true, prefs: prefs, buttonColor: buttonColor,)));
  return null;
}

void levelPageRedirect({BuildContext context, SharedPreferences prefs, Color buttonColor}){
  Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
  builder: (BuildContext context) => new LevelPage(difficulty: null, levelCheck: false, prefs: prefs, buttonColor: buttonColor,)), (Route route) => route == null);
}

void learnPageRedirect({BuildContext context, SharedPreferences prefs,
  String difficulty, String level, String option}){
  Navigator.of(context).pop();
  Navigator.of(context).push(new MaterialPageRoute(builder:
      (BuildContext context) => new LearnCards(prefs: prefs, difficulty: difficulty, level: level, option: option)));
}


void quizPageRedirect({BuildContext context, String difficulty,
  String level, Quiz quiz}){
  Navigator.of(context).pop();
  Navigator.of(context).push(new MaterialPageRoute(builder:
      (BuildContext context) => new QuizPage(difficulty: difficulty, level: level, quiz: quiz)));
}

void TFquizPageRedirect({BuildContext context, String difficulty,
  String level, TFQuiz quiz}){
  Navigator.of(context).pop();
  Navigator.of(context).push(new MaterialPageRoute(builder:
      (BuildContext context) => new TFQuizPage(difficulty: difficulty, level: level, quiz: quiz)));
}

void searchPageDirect({BuildContext context, SharedPreferences prefs, Color buttonColor}){
//   Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
//      builder: (BuildContext context) => new SearchPage(prefs: prefs)
//  ), (Route route) => route == null);
  Navigator.of(context).push(new MaterialPageRoute(builder:
      (BuildContext context) => new SearchPage(prefs: prefs, buttonColor: buttonColor,)));
}

void backDirect({BuildContext context}){
  Navigator.of(context).pop();
}


void singleWordPageDirect({BuildContext context, Vocab data, String word}){
  Navigator.of(context).push(new MaterialPageRoute(builder:
      (BuildContext context) => new SingleWord(vocab: data, word: word)));
}


void homePageDirect({BuildContext context, String page}){
  if(page != 'home')
    if (page == 'search'){
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
          builder: (BuildContext context) => new HomePage()
      ), (Route route) => route == null);
    }else {
      exitAlertBox(context).then((bool value) {
        if (value == true)
          Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage()
          ), (Route route) => route == null);
      });
    }
}


void settingDirect({BuildContext context}){
    Navigator.of(context).push(new MaterialPageRoute(builder:
      (BuildContext context) => new ColorPalette()));
}