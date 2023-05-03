import 'package:flutter/material.dart';
import "dart:math";

import 'quiz_page.dart';
import '../helpers/question_generator.dart';
import '../helpers/page_redirect.dart';
import '../UI/loading_circular_progress.dart';
import '../utils/quiz.dart';
import '../utils/question.dart';


class QuizStartPage extends StatefulWidget {
  QuizStartPage({
    @required this.level,
    @required this.difficulty
  });

  final String level;
  final String difficulty;

  _QuizStartPageState createState() => _QuizStartPageState();
}

class _QuizStartPageState extends State<QuizStartPage>{

  var rnd = Random();
  bool syn = false;
  List questionList;
  var choice;
  Quiz quiz;

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
      quiz = new Quiz(questionList);
      return new Material(
        color: Colors.white,
        child: new InkWell(
          onTap: () => quizPageRedirect(context: context, level: widget.level, difficulty: widget.difficulty, quiz: quiz),
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
        future: levelQGen(lv: widget.level, diff: widget.difficulty, syn: syn, questionList: questionList),
        builder: buildQuestions
    );
  }
}