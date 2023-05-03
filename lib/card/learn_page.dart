///the card section has been modified from
///

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'card_holder.dart';
import '../model/vocab.dart';
import '../model/db.dart';
import '../UI/loading_circular_progress.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';

class LearnCards extends StatefulWidget {
  LearnCards({
    @required this.prefs,
    @required this.difficulty,
    @required this.level,
    @required this.option
});

  SharedPreferences prefs;
  final String difficulty;
  final String level;
  final String option;

  @override
  LearnCardsState createState() => new LearnCardsState();
}

class LearnCardsState extends State<LearnCards> with TickerProviderStateMixin {
  VocabDatabase client;

  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  int totalLength;

  List wholeList;
  List selectedData = [];

  void initState() {
    super.initState();

    client = new VocabDatabase();

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

        rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          if (wholeList.length != 0) {
            var i = wholeList.removeLast();
            if (flag == 0) {
              wholeList.insert(0, i);
            }
          }
          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }


  void swipeRight(Vocab vocab) {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    setState(() {
      //wholeList.remove(vocab);
      selectedData.add(vocab);
    });
    _swipeAnimation();
  }

  void swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  void updateFav({Vocab vocab, int index}) async{
    print("update fav");
    await client.updateFavorite(vocab: vocab);
    setState(() {
      wholeList[index].favorite = wholeList[index].favorite == '0' ? '1' : '0';
    });
  }


  void updateKnown({Vocab vocab, int index, String state}) async{
    await client.updateKnown(vocab: vocab, state: state);
    setState((){
      wholeList[index].known = state;
    });
  }

  Future<List> getList() async {
    if (wholeList ==  null) {
      print("wholelist is null");
      wholeList = await client.queryLevel(lv: widget.level, diff: widget.difficulty);
      print(wholeList);
      if (wholeList.length == 0) {
        print("need to insert vocabs");
        wholeList = await new Vocab().loadList(widget.difficulty, widget.level);
        for (var i = 0; i < wholeList.length; i++) {
          print("start");
          var cur = new Vocab().getDetail(wholeList[i]);
          client.insert(cur);
          print('done');
        }
        wholeList = await client.queryLevel(lv: widget.level, diff: widget.difficulty);
      }
      switch(widget.option){
        case '0':
          break;
        case '1':
          wholeList = await client.queryLevelFavorite(lv: widget.level, diff: widget.difficulty);
          break;
        case '2':
          wholeList = await client.queryLevelKnown(lv: widget.level, diff: widget.difficulty);
          break;
        case '3':
          wholeList = await client.queryLevelUnknown(lv: widget.level, diff: widget.difficulty);
          break;
      }
      wholeList.shuffle();
    }
    return wholeList;
  }

  double _getBackCardWidth(){
    totalLength = selectedData.length + wholeList.length;
    double rst = (119.0 / totalLength) * selectedData.length;
    if (rst > 90.0){
      return 90.0;
    }
    return rst;
  }

  Widget buildCards(context, snapshot) {
    if (snapshot.hasData) {
      return Stack(
        children: [
          cardHolder(
            data: wholeList,
            rotate: rotate,
            right: right,
            bottom: bottom,
            width: width,
            flag: flag,
            parent: this,
            swipeRight: swipeRight,
            swipeLeft: swipeLeft,
            updateFav: updateFav,
            updateKnown: updateKnown,
            backCardWidth: _getBackCardWidth(),
            prefs: widget.prefs,
            difficulty: widget.difficulty,
            level: widget.level,
            option: widget.option,
           context: context
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Icon(
                OpenIconicIcons.expandDown
              ),
            )
          )
        ]
      );
    }
    else return new LoadingCircularProgress();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getList(),
      builder: buildCards,
    );
  }
}
