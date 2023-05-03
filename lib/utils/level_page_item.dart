///Modified from https://github.com/roughike/page-transformer

import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../UI/page_transformer.dart';
import '../utils/level_data.dart';

class LevelPageItem extends StatelessWidget {
  LevelPageItem({
    @required this.item,
    @required this.pageVisibility,
    @required this.level,
    @required this.pageColor
  });

  final PageVisibility pageVisibility;
  final LevelItem item;
  final bool level;
  final Color pageColor;


  List<Widget> _genLevel(textTheme){
    List<Widget> rst = [];
    //rst.add(new Icon(OpenIconicIcons.lockLocked, color: Colors.white, size: 60.0));
    rst.add(new Text(item.difficulty,
          style: new TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontSize: 30.0,
          )
        )
    );
    return rst;
  }


  List<Widget> _genLevelDetail(textTheme){
    List<Widget> rst = [];
    rst.add(new Text(item.difficulty, style: textTheme.caption.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 4.0,
        fontSize: 19.0,
      ),
        textAlign: TextAlign.justify,
      ),
    );
    rst.add(new Divider(height: 15.0));
    rst.add(new Text('Level ' + item.level, style: textTheme.caption.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
        fontSize: 26.0,
      ),
      textAlign: TextAlign.center,
    ));
    return rst;
  }

  _buildTextContainer(BuildContext context) {
    var titleText;
    var textTheme = Theme.of(context).textTheme;
    if(level==false) {
      titleText = _genLevel(textTheme);
    }
    else{
      titleText = _genLevelDetail(textTheme);
    }

    return Positioned(
      bottom: 66.0,
      left: 34.0,
      right: 34.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: titleText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Material(
        color: pageColor,
        elevation: 6.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _buildTextContainer(context),
          ],
        ),
      ),
    );
  }
}
