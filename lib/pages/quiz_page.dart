import 'dart:async';

import 'package:flutter/material.dart';

import '../pages/score_page.dart';

import '../utils/quiz.dart';
import '../utils/question.dart';

import 'package:vocab_app/navbuttons/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/button_overlay.dart';


class QuizPage extends StatefulWidget {
  QuizPage({
    @required this.level,
    @required this.difficulty,
    @required this.quiz
});

  final String level;
  final String difficulty;
  final Quiz quiz;

  List<Widget> rst = [];

  @override
  State createState() => new QuizPageState();

}

class QuizPageState extends State<QuizPage>{

  Question currentQuestion;

  String questionText;
  String answerText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
  bool pressed;
  bool buttonPressed;
  List curOptions;
  int pressedButtonIndex;

  final ms = const Duration(milliseconds: 1);

  @override
  void initState() {
    super.initState();
    pressed = false;
    currentQuestion = widget.quiz.nextQuestion;
    questionText = currentQuestion.question;
    answerText = currentQuestion.answer;
    questionNumber = widget.quiz.questionNumber;
    curOptions = currentQuestion.options;
    curOptions.add(answerText);
  }


  bool handleAnswer(String answer){
    isCorrect = (answer == answerText);
    widget.quiz.answer(isCorrect);
    return isCorrect;
  }



  void updateParent(int index){
    setState(() {
      pressedButtonIndex = index;
      overlayShouldBeVisible = true;
      pressed = true;
    });
    if (widget.quiz.length+1 != questionNumber){
      startTime(2000);
    }
  }


  void handleTimeout(){
    if (widget.quiz.length  == questionNumber){
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
          builder: (BuildContext context) => new ScorePage(widget.quiz.score, widget.quiz.length)
      ), (Route route) => route == null);
      return;
    }
    currentQuestion = widget.quiz.nextQuestion;
    this.setState(() {
      questionText = currentQuestion.question;
      questionNumber = widget.quiz.questionNumber;
      answerText = currentQuestion.answer;
      curOptions = currentQuestion.options;
      curOptions.add(answerText);
      overlayShouldBeVisible = false;
      pressed = false;
      buttonPressed = false;
      pressedButtonIndex = null;
    });

  }

  Timer startTime(int milliseconds){
    var duration = ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }


  List<Widget> _createChildren(){
      widget.rst = [];
      widget.rst.add(new QuestionText(questionText, questionNumber));
      if(overlayShouldBeVisible == false) curOptions.shuffle();
      for (var i = 0; i < curOptions.length; i ++) {
        if(i == pressedButtonIndex) buttonPressed = true;
        else buttonPressed = false;
        widget.rst.add(
            new AnswerButton(
              answer: curOptions[i],
              correctAnswer: handleAnswer(curOptions[i]),
              updateParent: updateParent,
              parentPressed: pressed,
              buttonPressed: buttonPressed,
              buttonIndex: i,
        ));
      }

      return widget.rst;
  }


  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
              children: _createChildren()
          ),
          overlayShouldBeVisible == true
              ? new ButtonOverlay()
              : new Container(),
        ],
      ),
    );
  }
}