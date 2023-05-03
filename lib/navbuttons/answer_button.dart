import 'package:flutter/material.dart';

class AnswerButton extends StatefulWidget {

  AnswerButton({
    @required this.answer,
    @required this.correctAnswer,
    @required this.updateParent,
    @required this.parentPressed,
    @required this.buttonPressed,
    @required this.buttonIndex,
});

  final String answer;
  final bool correctAnswer;
  final bool parentPressed;
  final int buttonIndex;
  final Function updateParent;
  final timeout = const Duration(seconds: 3);
  final ms = const Duration(milliseconds: 1);

  bool buttonPressed;

    @override
    State createState() => new AnswerButtonState();
}

class AnswerButtonState extends State<AnswerButton> {

  void _onTap(){
      this.setState(() {
        widget.buttonPressed = true;
        widget.updateParent(widget.buttonIndex);
    });

  }

  Color _getColor(){
    if(widget.buttonPressed){
      if (widget.correctAnswer)
        return Colors.greenAccent;
      else return Colors.redAccent;
    }
    else if(widget.parentPressed){
      if (widget.correctAnswer)
        return Colors.greenAccent;
    }

    return Colors.white;
  }

  @override
  Widget build(BuildContext context){
    return new FlatButton(
           onPressed: _onTap,
           padding: new EdgeInsets.all(9.0), //ternary operator
           child: new Container(
           width: 250.0,
           height: 70.0,
           alignment: Alignment.center,
           decoration: new BoxDecoration(
             color: _getColor(),
             border: new Border.all(color: Colors.blue),
             borderRadius: new BorderRadius.circular(30.0),
           ),
             child: new Text(widget.answer,
                 style: new TextStyle(color: Colors.black,
                     fontSize: 26.0)),
           ),
    //),
    );
  }
}


