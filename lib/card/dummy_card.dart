import 'package:flutter/material.dart';

import '../model/vocab.dart';
import '../helpers/cardwidget_helper.dart';

Positioned DummyCard(
    Vocab vocab,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    Color cardColor,
    bool checkOrder,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;

  return new Positioned(
    bottom: screenSize.height/6.3 + bottom,
    child: new Card(
      color: Colors.transparent,
      elevation: 4.0,
      child: new Container(
        alignment: Alignment.center,
        width: screenSize.width / 1.7 + cardWidth,
        height: screenSize.height / 1.7,
        decoration: new BoxDecoration(
          color: cardColor,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Column(
          children: widgetGen(vocab: vocab, screenSize: screenSize, cardWidth: cardWidth, checkOrder: checkOrder)
                )),
        ),
  );
}
