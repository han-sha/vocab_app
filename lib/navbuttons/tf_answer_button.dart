import 'package:flutter/material.dart';

class TFAnswerButton extends StatefulWidget {

  TFAnswerButton({
    @required this.answer,
    @required this.correctAnswer,
    @required this.updateParent,
   // @required this.parentContext,
    //@required this.parentPressed,
    //@required this.buttonPressed,
    //@required this.buttonIndex,
  });

  final String answer;
  final String correctAnswer;
  //final bool parentPressed;
  //final int buttonIndex;
  final Function updateParent;
  //BuildContext parentContext;
 // bool buttonPressed;

  @override
  _TFAnswerButtonState createState() => _TFAnswerButtonState();
}

class _TFAnswerButtonState extends State<TFAnswerButton> {

//  Widget _getIcon(){
//    if(widget.answer == true){
//      return Icon(
//        Icons.check,
//        color: Colors.black,
//        size: 26.0,
//      );
//    } else {
//      return Icon(
//        Icons.close,
//        color: Colors.black,
//        size: 26.0,
//
//      );
//    }
//  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool correctness;

    if(widget.answer == widget.correctAnswer) correctness = true;
    else correctness = false;

    return TextButton(
      onPressed: ()=> widget.updateParent(
          correct: correctness,
          //contxt: widget.parentContext,
      ),
      child: Container(
        width: screenSize.width / 2 - 35.0,
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromRGBO(0, 0, 0, 0.4),
            ),
          borderRadius: BorderRadius.circular(19.0),
        ),
        //child: _getIcon(),
        child: Text(
          widget.answer.toString(),
          style: TextStyle(
            letterSpacing: 3.0,
            fontSize: 19.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
