import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../model/vocab.dart';
import '../helpers/learnpage_helper.dart';

class CardDetail extends StatefulWidget {
  CardDetail({
    @required this.vocab,
    @required this.themeColor
  });

  final Vocab vocab;
  final Color themeColor;

  @override
  _CardDetailState createState() => new _CardDetailState();
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _CardDetailState extends State<CardDetail> with TickerProviderStateMixin {
  AnimationController _containerController;
  Animation<double> width;
  Animation<double> heigth;

  double _appBarHeight = 166.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  void initState() {
    _containerController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width = new Tween<double>(
      begin: 100.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth = new Tween<double>(
      begin: 400.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth.addListener(() {
      setState(() {
        if (heigth.isCompleted) {}
      });
    });
    _containerController.forward();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.7;
    return new Hero(
      tag: "img",
      child: new Card(
        child: new Container(
          alignment: Alignment.center,
          width: width.value,
          height: heigth.value,
          child: new Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              new CustomScrollView(
                shrinkWrap: false,
                slivers: <Widget>[
                  new SliverAppBar(
                    backgroundColor: widget.themeColor,
                    expandedHeight: _appBarHeight,
                    pinned: _appBarBehavior == AppBarBehavior.pinned,
                    floating: _appBarBehavior == AppBarBehavior.floating ||
                        _appBarBehavior == AppBarBehavior.snapping,
                    //snap: _appBarBehavior == AppBarBehavior.snapping,
                    flexibleSpace: new FlexibleSpaceBar(
                        title: new Text(widget.vocab.vword, style: new TextStyle(fontSize: 39.0)),
                        centerTitle: true
                    ),
                  ),
                  new SliverList(
                    delegate: new SliverChildListDelegate(<Widget>[
                      new Container(
                        color: Colors.white,
                        child: new Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: getWordDetail(widget.vocab)
                          ),
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
}
