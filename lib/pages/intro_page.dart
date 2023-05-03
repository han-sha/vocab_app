import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "dart:async";

import "level_page.dart";
import "../UI/heartbeat.dart";

class IntroPage extends StatefulWidget{

  @override
  _IntroPageState createState ()=> _IntroPageState();
}

class _IntroPageState extends State<IntroPage>{
  SharedPreferences prefs;

  final timeout = const Duration(seconds: 3);
  final ms = const Duration(milliseconds: 1);
  var timer;
  var snapshotData;

  @override
  void initState(){
    super.initState();
    timer = startTimeout(8000);
  }

  Future<SharedPreferences> initPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String theme = prefs.getString('theme');
    if (theme == null){
     prefs.setString('theme', 'blue');
    }
    return prefs;
  }

  void handleTimeout (){
//    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
//        builder: (BuildContext context) => new LevelPage(difficulty: null, levelCheck: false, prefs: snapshotData)
//    ), (Route route) => route == null);
    return;
  }

  Timer startTimeout([int milliseconds]){
    var duration = ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }


  void _cancelTimeout(){
    timer.cancel();
//    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
//        builder: (BuildContext context) => new LevelPage(difficulty: null, levelCheck: false, prefs: snapshotData)
//    ), (Route route) => route == null);
  }

  @override
  Widget build(BuildContext context){
    return new FutureBuilder(
      builder: (BuildContext context, snapshot){
        if (snapshot.hasData) {
          snapshotData = snapshot.data;
          return new Material(
            child: new InkWell(
              onTap: _cancelTimeout,
              child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text("made with",
                    style: new TextStyle(color: Colors.black, fontSize: 26.0)),
                new Divider(height: 16.0),
                new HeartBeat(x: 0.0, y: 0.0),
                new Divider(height: 16.0),
                new Text("all word choice credits go to",
                    style: new TextStyle(color: Colors.black, fontSize: 16.0), textAlign: TextAlign.end),
                new Text(" Economics.com",
                    style: new TextStyle(color: Colors.black, fontSize: 16.0))
              ],
            ),
            ),
          );
        }
        return new Center(
          child: new CircularProgressIndicator(),
        );
      },
      future: initPreferences()
    );
  }
}