import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_app/helpers/page_redirect.dart';
import 'package:vocab_app/navbuttons/level_up_button.dart';
import 'dart:async';
import 'dart:math';

import '../model/db.dart';

class GamePlay extends StatefulWidget {
  GamePlay({
    @required this.data,
    @required this.buttonColor,
    @required this.prefs,
    @required this.pageContext,
  });

  List data;
  Color buttonColor;
  SharedPreferences prefs;
  BuildContext pageContext;

  @override
  _GamePlayState createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  var _x;
  var _y;
  var _numGen = new Random();
  var _quadGen = new Random();
  var index = 0;
  final ms = const Duration(milliseconds: 1);
  bool _visible = true;
  int counter = 0;

  var timer;

  @override
  void initState() {
    super.initState();
    _x = _numGen.nextDouble();
    _y = _numGen.nextDouble();
    timer = startTimeout(2000);
  }

  double posGen(bool x) {
    var gen = _numGen.nextDouble();
    if (x == true) {
      while ((gen == 0.0) || (gen > 0.85)) gen = _numGen.nextDouble();
    }
    if (x == false) {
      while ((gen < 0.23) || (gen > 0.85)) gen = _numGen.nextDouble();
    }
    var quad = _quadGen.nextBool();
    if (quad == false) gen = (-1.0) * gen;
    return gen;
  }

  void handleTimeout() {
    setState(() {
      _visible = !_visible;
      if (counter % 2 == 1) {
        if (index < widget.data.length - 1)
          index += 1;
        else
          index = 0;
        _x = posGen(true);
        _y = posGen(false);
      }
      counter += 1;
    });
  }

  Timer startTimeout([int milliseconds]) {
    print("start timeout");
    var oneSec = ms * milliseconds;
    return new Timer.periodic(oneSec, (Timer t) => handleTimeout());
  }

  void _wordTap({BuildContext context}) {
    if (_visible == true)
      singleWordPageDirect(context: context, data: widget.data[index]);
  }

  Widget _getChild() {
    return new Text(widget.data[index].vword,
        style: new TextStyle(color: Colors.black, fontSize: 24.0));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.length > 0)
      return Material(
        color: Colors.white70,
        child: Stack(children: [
          Align(
            alignment: Alignment(0.0, -0.1),
            child: LevelUpButton(
              buttonColor: widget.buttonColor,
              prefs: widget.prefs,
              pageContext: widget.pageContext,
            ),
          ),
          Align(
            alignment: Alignment(_x, _y),
            child: InkWell(
              onTap: () => _wordTap(context: context),
              child: AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: _getChild(),
              ),
            ),
          ),
        ]),
      );
    else
      return Material(
        color: Colors.white70,
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0.0, -0.1),
              child: LevelUpButton(
                buttonColor: widget.buttonColor,
                prefs: widget.prefs,
                pageContext: widget.pageContext,
              ),
            ),
          ],
        ),
      );
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }
}
