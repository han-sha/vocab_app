import 'package:flutter/material.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';

class KnownButton extends StatefulWidget{

  @override
  State createState() => new KnownButtonState();
}

class KnownButtonState extends State<KnownButton>{

  bool _yes = false;

  void _check(){
    this.setState((){
      _yes =! _yes;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Align(
      //alignment: new Alignment(50.0, 50.0),
      child: new InkWell(
          onTap: ()=> _check(),
          child: new Container(
            height: 60.0,
            width: 120.0,
            decoration: new BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: new BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))
            ),
            child: _yes == false? new Icon(OpenIconicIcons.check, size: 36.0, color: Colors.white.withOpacity(0.6)) :
            new Icon(OpenIconicIcons.check, size: 36.0, color: Colors.white)
          ),
        ),
      );
    }
  }
