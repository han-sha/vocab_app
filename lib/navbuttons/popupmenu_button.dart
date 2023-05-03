import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:flutter/material.dart';

import '../helpers/page_redirect.dart';

class PopupMenu extends StatefulWidget{
  PopupMenu({
    @required this.level,
    @required this.difficulty,
    @required this.context,
    @required this.prefs
});

  final String level;
  final String difficulty;
  final BuildContext context;
  final SharedPreferences prefs;

  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu>{

  void _redirect(String value){
    learnPageRedirect(context: context, level: widget.level,
      difficulty: widget.difficulty, prefs: widget.prefs, option: value);
  }

  @override
  Widget build(BuildContext context) {
    return new PopupMenuButton<String>(
      onSelected: _redirect,
        icon: new Icon(OpenIconicIcons.menu, color: Colors.cyan, size: 21.0),
        itemBuilder: (_) => <PopupMenuItem<String>>[
          new PopupMenuItem<String>(
            child: new Text('all words'), value: '0'
          ),
          new PopupMenuItem<String>(
              child: new Text('favorite words'), value: '1'
          ),
          new PopupMenuItem<String>(
              child: new Text('known words'), value: '2'
          ),
          new PopupMenuItem<String>(
              child: new Text('unknown words'), value: '3'
          )
        ]
    );
  }
}



