

import 'package:vocab_app/utils/tf_question.dart';

class TFQuiz {
  List _questions;
  int _currentQuestionIndex = -1;
  int _score = 0;

  TFQuiz(this._questions);

  List get questions => _questions;
  int get length => _questions.length;
  int get questionNumber => _currentQuestionIndex+1;
  int get score => _score;

  TFqs get nextQuestion{
    _currentQuestionIndex++;
    if (_currentQuestionIndex >= length) return null;
    return _questions[_currentQuestionIndex];
  }

  void answer(bool isCorrect){
    if (isCorrect) _score++;
  }
}

