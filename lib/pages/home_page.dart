import 'package:flutter/material.dart';
import 'package:vocab_app/UI/bottom_appbar.dart';
import 'package:vocab_app/UI/loading_circular_progress.dart';
import 'package:vocab_app/helpers/page_redirect.dart';
import 'package:vocab_app/helpers/setcolors_helper.dart';
import 'package:vocab_app/radial_menu/export_radial_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../game/game.dart';
import '../model/db.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;
  List wordList;
  List randomSixty;
  VocabDatabase client;
  Color buttonColor;
  Color expandedBubbleColor;
  Color openBubbleColor;
  String theme;

  @override
  void initState() {
    super.initState();
    client = new VocabDatabase();
  }

  Future<List> init() async {
    prefs = await SharedPreferences.getInstance();
    theme = prefs.getString('theme');
    print(theme);
    if (theme == null) {
      prefs.setString('theme', 'blue');
      theme = 'blue';
    }

    buttonColor = getPageButtonColor(theme);

    //if (wordList == null) wordList = await client.queryAll();
    if (randomSixty == null) randomSixty = await client.getRandomSixty();

    return randomSixty;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                bottomNavigationBar: ScaffoldBottomAppBar(
                    parentContext: context,
                    buttonColor: buttonColor,
                    prefs: prefs,
                    curPage: 'home',
                ),
                body: Stack(
                  children: [
                    Align(
                      child: GamePlay(
                        data: randomSixty,
                        buttonColor: buttonColor,
                        prefs: prefs,
                        pageContext: context,
                      ),
                    ),
//                buildRadialMenu(
//                  context: context,
//                  prefs: prefs,
//                  wordList: wordList,
//                  curPage: 'home',
//                  showOverlay: false,
//                ),
              ],
            ));
          } else
            return LoadingCircularProgress();
        },
        future: init());
  }
}
