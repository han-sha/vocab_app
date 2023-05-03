import 'package:flutter/material.dart';
import 'package:vocab_app/helpers/learnpage_helper.dart';
import 'package:vocab_app/model/vocab.dart';

Widget singleWordHero({
  Vocab vocab,
}) {
  return new Hero(
    tag: "word",
    child: new Card(
      child: new Container(
        alignment: Alignment.center,
        child: new Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            new CustomScrollView(
              shrinkWrap: false,
              slivers: <Widget>[
                new SliverAppBar(
                  pinned: true,
                  flexibleSpace: new FlexibleSpaceBar(
                      title: new Text(vocab.vword,
                          style: new TextStyle(fontSize: 39.0)),
                      centerTitle: true),
                ),
                new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                    new Container(
                      color: Colors.white,
                      child: new Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getWordDetail(vocab)),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
