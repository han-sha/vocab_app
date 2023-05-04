import 'package:flutter/material.dart';

import 'card_detail.dart';
import '../helpers/cardwidget_helper.dart';
import '../UI/palette_colors.dart';
import '../model/vocab.dart';

Positioned ActiveCard(
    Vocab vocab,
    int index,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    Color cardColor,
    BuildContext context,
    int flag,
    Function swipeRight,
    Function swipeLeft,
    Function updateFav,
    Function updateKnown) {
  Size screenSize = MediaQuery.of(context).size;

  return new Positioned(
    bottom: screenSize.height / 6.3 + bottom,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: new Transform(
      alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
      transform: new Matrix4.skewX(skew),
      child: new RotationTransition(
        turns: new AlwaysStoppedAnimation(
            flag == 0 ? rotation / 360 : -rotation / 360),
        child: new Hero(
          tag: "img",
          child: new GestureDetector(
            onTap: () {
              Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new CardDetail(vocab: vocab, themeColor: cardColor),
              ));
            },
            child: new Card(
              color: Colors.transparent,
              elevation: 4.0,
              child: new Container(
                alignment: Alignment.center,
                width: screenSize.width / 1.7 + 115.0,
                height: screenSize.height / 1.7,
                decoration: new BoxDecoration(
                  color: cardColor,
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                child: new Column(
                  children: <Widget>[
                    new Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 16.0, 13.0, 0.0),
                    child: new Container(
                        alignment: Alignment.topRight,
                        child: new InkWell(
                          onTap: () => updateFav(vocab: vocab, index: index),
                          child: getIcon(vocab)
                        ),
                      )
                    ),
                    new Container(
                        alignment: Alignment.center,
                        width: screenSize.width / 1.2 + cardWidth,
                        height: screenSize.height / 2.5,
                        child: new Text(vocab.vword, style: new TextStyle(color: Colors.white, fontSize: 36.0),
                            textAlign: TextAlign.center)
                    ),
                    new Container(
                        width: screenSize.width / 1.2 + cardWidth,
                        height: screenSize.height / 1.7 - screenSize.height / 2.0,
                        alignment: Alignment.center,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(0)),
                                ),
                                onPressed: () {
                                  swipeLeft();
                                  updateKnown(vocab: vocab, index: index, state: '0');
                                },
                                child: new Container(
                                  height: 60.0,
                                  width: 130.0,
                                  alignment: Alignment.center,
                                  decoration: new BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    new BorderRadius.circular(60.0),
                                  ),
                                  child: getUnknown(vocab)
                                )),
                            new TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(0)),
                                ),
                                onPressed: () {
                                  swipeRight(vocab);
                                  updateKnown(vocab: vocab, index: index, state: '1');
                                },
                                child: new Container(
                                  height: 60.0,
                                  width: 130.0,
                                  alignment: Alignment.center,
                                  decoration: new BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius:
                                    new BorderRadius.circular(60.0),
                                  ),
                                  child: getKnown(vocab),
                                ))
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}