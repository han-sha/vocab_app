import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:flutter/material.dart';
import '../model/vocab.dart';
import '../UI/palette_colors.dart';

Widget getIcon(Vocab vocab){
  if(vocab.favorite == '0'){
    return new Icon(Icons.favorite_border, size: 39.0, color: heartColor);
  }
  return new Icon(Icons.favorite, size: 39.0, color: heartColor);
}

Widget getUnknown(Vocab vocab){
  if (vocab.known == '0') return new Text("don't know", style: new TextStyle(color: Colors.white, fontSize: 20.0));
  return new Text("forgot", style: new TextStyle(color: Colors.white, fontSize: 24.0));
}

Widget getKnown(Vocab vocab){
  if (vocab.known == '0') return new Text("know", style: new TextStyle(color: Colors.white, fontSize: 22.0));
  return new Icon(OpenIconicIcons.check, color: Colors.white, size: 34.0,);
}

/// for dummy cards
List<Widget> widgetGen({Vocab vocab, bool checkOrder, Size screenSize, double cardWidth}){
  List<Widget> rst = [];
  rst.add(new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 13.0, 0.0),
      child: new Container(
          alignment: Alignment.topRight,
          child:  getIcon(vocab))));

  rst.add(new Container(alignment: Alignment.center,
      width: screenSize.width / 1.2 + cardWidth,
      height: screenSize.height / 2.5,
      child: new Text(vocab.vword, style: new TextStyle(color: Colors.white, fontSize: 36.0), textAlign: TextAlign.center)));

  if(checkOrder == true){
    rst.add(new Container(
        width: screenSize.width / 1.2 + cardWidth,
        height: screenSize.height / 1.7 - screenSize.height / 2.0,
        alignment: Alignment.center,
        child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new FlatButton(
                  padding: new EdgeInsets.all(0.0),
                  onPressed: () {},
                  child: new Container(
                    height: 60.0, width: 130.0, alignment: Alignment.center,
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: new BorderRadius.circular(60.0),
                    ),
                    child: getUnknown(vocab),
                  )),
              new FlatButton(
                  padding: new EdgeInsets.all(0.0),
                  onPressed: () {},
                  child: new Container(
                    height: 60.0,
                    width: 130.0,
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: new BorderRadius.circular(60.0)),
                    child: getKnown(vocab),))])));
  }

  return rst;
}