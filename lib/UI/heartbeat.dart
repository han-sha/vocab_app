import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../UI/palette_colors.dart';

class HeartBeat extends StatefulWidget{

  HeartBeat({
    @required this.x,
    @required this.y
  });

  final double x;
  final double y;
  @override
  _HeartBeatState createState ()=> _HeartBeatState();
}

class _HeartBeatState extends State<HeartBeat>{
  final ms = const Duration(milliseconds: 1);
  var _size = 36.0;
  var _expand = true;
  var timer;

  @override
  void initState(){
    super.initState();
    timer = startTimeout(1000);
  }

  void handleTimeout (){
    setState(() {
      _expand =! _expand;
      if(_expand == false) _size = 28.0;
      else _size = 36.0;
    });

  }

  Timer startTimeout([int milliseconds]){
    var oneSec = ms * milliseconds;
    return new Timer.periodic(oneSec, (Timer t) => handleTimeout());
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Align(
            alignment: new Alignment(widget.x, widget.y),
            child: new Icon(OpenIconicIcons.heart, size: _size, color: heartColor)
      ),
    );
  }

  @override
  dispose(){
    timer.cancel();
    super.dispose();
  }

}