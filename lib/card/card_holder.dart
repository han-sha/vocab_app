import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';

import 'dummy_card.dart';
import 'active_card.dart';
import 'learn_page.dart';
import '../model/vocab.dart';
import '../helpers/setcolors_helper.dart';
import '../helpers/page_redirect.dart';
import 'package:vocab_app/navbuttons/popupmenu_button.dart';

Scaffold cardHolder({
  List data,
  Animation<double> rotate,
  Animation<double> right,
  Animation<double> bottom,
  Animation<double> width,
  Function dismissImg,
  int flag,
  LearnCardsState parent,
  double backCardWidth,
  Function addImg,
  Function swipeRight,
  Function swipeLeft,
  Function updateFav,
  Function updateKnown,
  SharedPreferences prefs,
  String difficulty,
  String level,
  String option,
  BuildContext context}){

  var theme = prefs.getString("theme");
  Color color1 = getColor(theme, "learn1");
  var cardColor;
  var dataLength = data.length;
  timeDilation = 0.4;
  double initialBottom = 15.0;
  double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;

  return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: new PopupMenu(level: level, difficulty: difficulty, context: context, prefs: prefs),
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "REMAINING",
              style: new TextStyle(
                  fontSize: 12.0,
                  letterSpacing: 3.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            new Container(
              width: 18.0,
              height: 18.0,
              margin: new EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.center,
              child: new Text(
                dataLength.toString(),
                style: new TextStyle(fontSize: 13.0),
              ),
              decoration: new BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
            )
          ],
        ),
        actions: <Widget>[
          new Container(margin: const EdgeInsets.all(15.0),
              child: new InkWell(
                  onTap: () => learnPageRedirect(context: context, prefs: prefs,
                  difficulty: difficulty, level: level, option: option),
                  child: new Icon(OpenIconicIcons.reload, color: Colors.cyan, size: 21.0)
              ),
          ),
        ],
      ),
      body: new Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: dataLength > 0
            ? new Stack(
            alignment: AlignmentDirectional.center,
            children: data.map((item) {
              cardColor = color1;
              if (data.indexOf(item) == dataLength - 1) {
//                print(data.indexOf(item));
                return ActiveCard(
                    item,
                    data.indexOf(item),
                    bottom.value,
                    right.value,
                    0.0,
                    backCardWidth + 10,
                    rotate.value,
                    rotate.value < -10 ? 0.1 : 0.0,
                    cardColor,
                    context,
                    flag,
                    swipeRight,
                    swipeLeft,
                    updateFav,
                    updateKnown);
              } else {
                bool checkOrder = false;
                if(data.indexOf(item) == dataLength - 2) checkOrder = true;
                backCardPosition = backCardPosition - 10;
                backCardWidth = backCardWidth + (119.0/(dataLength + parent.selectedData.length));
                return DummyCard(item, backCardPosition, 0.0, 0.0,
                    backCardWidth, 0.0, 0.0, cardColor, checkOrder, context);
              }
            }).toList())
            : new Text("No Words Left",
            style: new TextStyle(color: Colors.black, fontSize: 50.0)),
      )
  );}