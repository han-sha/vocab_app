import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vocab_app/UI/button_overlay.dart';
import 'package:vocab_app/UI/palette_colors.dart';
import 'package:vocab_app/helpers/page_redirect.dart';
import 'package:vocab_app/model/db.dart';
import 'package:vocab_app/navbuttons/tf_answer_button.dart';
import 'package:vocab_app/utils/tf_question.dart';
import 'package:vocab_app/utils/tf_quiz.dart';

class TFQuizPage extends StatefulWidget {
  TFQuizPage({
    @required this.level,
    @required this.difficulty,
    @required this.quiz,
  });

  final String level;
  final String difficulty;
  final TFQuiz quiz;

  @override
  _TFQuizPageState createState() => _TFQuizPageState();
}

class _TFQuizPageState extends State<TFQuizPage> {
  TFqs currentQuestion;

  String word;
  String choice;
  String type;
  bool answer;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;
  bool pressed;
  bool buttonPressed;
  int pressedButtonIndex;
  Color overlayColor;

  final ms = const Duration(milliseconds: 1);

  @override
  void initState() {
    super.initState();
    pressed = false;
    currentQuestion = widget.quiz.nextQuestion;
    word = currentQuestion.word;
    choice = currentQuestion.choice;
    type = currentQuestion.type;
    //answer = currentQuestion.answer;
    questionNumber = widget.quiz.questionNumber;
  }

  bool handleAnswer(bool ans) {
    isCorrect = (ans == answer);
    widget.quiz.answer(isCorrect);
    return isCorrect;
  }

  void updateParent({bool correct}) {
    setState(() {
      if (correct == true) {
        overlayColor = Qright;
      }
      else {
        overlayColor = Qwrong;
        //singleWordPageDirect(context: context);
      }
        overlayShouldBeVisible = true;
        pressed = true;
    });
    if (correct == false){
      startTime(500, singleWordTimeout);
    }
    if (widget.quiz.length + 1 != questionNumber) {
      startTime(2000, handleTimeout);
    }
  }


  void singleWordTimeout(){
    singleWordPageDirect(context: context, word: word);
  }

  void handleTimeout() {
    if (widget.quiz.length == questionNumber) {
      print("done!");
//      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
//          builder: (BuildContext context) => new ScorePage(widget.quiz.score, widget.quiz.length)
//      ), (Route route) => route == null);
      return;
    }
    currentQuestion = widget.quiz.nextQuestion;
    this.setState(() {
      word = currentQuestion.word;
      questionNumber = widget.quiz.questionNumber;
      type = currentQuestion.type;
      //answer = currentQuestion.answer;
      choice = currentQuestion.choice;
      overlayShouldBeVisible = false;
      pressed = false;
      buttonPressed = false;
      pressedButtonIndex = null;
    });
  }

  Timer startTime(int milliseconds, funcTimeout) {
    var duration = ms * milliseconds;
    return new Timer(duration, funcTimeout);
  }

  @override
  Widget build(BuildContext context) {
    String type_text;
    Color highlight;
    if (type == 's') {
      type_text = 'synonym';
      highlight = QSyn;
    } else {
      type_text = 'antonym';
      highlight = QAnto;
    }

    return new Material(
      child: Stack(
        children: [
          overlayShouldBeVisible == true
              ? ButtonOverlay(
                  overlayColor: overlayColor,
                )
              : Container(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$word',
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                      background: Paint()..color = QSyn,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      '$choice',
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                        background: Paint()..color = QAnto,
                      ),
                    ),
                  ),

//                    Padding(
//                      padding: const EdgeInsets.all(16.0),
//                      child: RichText(
//                        text: TextSpan(
//                            style: TextStyle(
//                              color: Colors.black,
//                              letterSpacing: 1.0,
//                            ),
//                            children: [
//                              TextSpan(
//                                text: "$choice",
//                                style: TextStyle(
//                                  fontSize: 23.0,
//                                  letterSpacing: 2.0,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              ),
//                              TextSpan(
//                                text: " and ",
//                                style: TextStyle(
//                                  fontSize: 19.0,
//                                ),
//                              ),
//                              TextSpan(
//                                text: "$word",
//                                style: TextStyle(
//                                  fontSize: 23.0,
//                                  letterSpacing: 2.0,
//                                  fontWeight: FontWeight.bold,
//                                ),
//                              ),
//                            ]),
//                      ),
//                    ),
                ],
              ),
            ),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 79.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TFAnswerButton(
                    answer: "synonym",
                    correctAnswer: type,
                    updateParent: updateParent,
                    //updateParent: ,
                  ),
                  Expanded(child: Container()),
                  TFAnswerButton(
                    answer: "antonym",
                    correctAnswer: type,
                    updateParent: updateParent,
                    // updateParent: ,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                questionNumber.toString() +
                    " / " +
                    widget.quiz.length.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
//          overlayShouldBeVisible == true
//              ? new ButtonOverlay(
//            overlayColor: overlayColor,
//          )
//              : new Container(),
        ],
      ),
    );
  }
}
