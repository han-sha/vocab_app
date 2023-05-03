import 'package:flutter/material.dart';
import 'package:vocab_app/utils/tf_quiz.dart';
import "dart:math";

import 'quiz_page.dart';
import '../helpers/question_generator.dart';
import '../helpers/page_redirect.dart';
import '../UI/loading_circular_progress.dart';
import '../utils/quiz.dart';
import '../utils/question.dart';


class TFQuizStartPage extends StatefulWidget {
  TFQuizStartPage({
    @required this.level,
    @required this.difficulty
  });

  final String level;
  final String difficulty;

  _TFQuizStartPageState createState() => _TFQuizStartPageState();
}

class _TFQuizStartPageState extends State<TFQuizStartPage>{

  var rnd = Random();
  bool syn = false;
  List questionList;
  var choice;
  TFQuiz quiz;

  @override
  void initState() {
    super.initState();
    syn = rnd.nextBool();
    if(syn == true) choice = 'synonym';
    else choice = 'antonym';
  }

  Widget buildQuestions(context, snapshot) {
    if (snapshot.hasData) {
      questionList = snapshot.data;
      quiz = new TFQuiz(questionList);
      return new Material(
        color: Colors.white,
        child: new InkWell(
            onTap: () => TFquizPageRedirect(context: context, level: widget.level, difficulty: widget.difficulty, quiz: quiz),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  new Text("for this quiz, please choose the $choice of the given word"),
                  new Text("tap to start")
                ]
            )
        ),
      );
    }else return new LoadingCircularProgress();

  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: levelTFGen(lv: widget.level, diff: widget.difficulty, questionList: questionList),
        builder: buildQuestions
    );
  }
}