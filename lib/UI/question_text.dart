import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget{

  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  State createState() => new QuestionTextState();

}

class QuestionTextState extends State<QuestionText> {


  @override
  Widget build(BuildContext context){
    return new Material(
      child: new Padding(
        padding: new EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 30.0),
        child: new Center(
          child: new Center(
            child: new Text(widget._question,
            style: new TextStyle(fontSize: 53.0, fontWeight: FontWeight.bold,
            color: Colors.black )
            ),
            //style: new TextStyle(fontSize: _fontSizeAnimation.value * 15)
            ),
          ),
        ),
    );
  }
}