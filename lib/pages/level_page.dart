import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:vocab_app/UI/app_bar.dart';
import 'package:vocab_app/UI/bottom_appbar.dart';

import "package:vocab_app/utils/level_page_item.dart";
import "package:vocab_app/utils/level_data.dart";
import "package:vocab_app/UI/page_transformer.dart";
import "../helpers/setcolors_helper.dart";
import "../helpers/page_redirect.dart";

class LevelPage extends StatefulWidget{
  LevelPage({
    @required this.levelCheck,
    @required this.difficulty,
    @required this.prefs,
    @required this.buttonColor,
  });

  final bool levelCheck;
  final String difficulty;
  SharedPreferences prefs;
  Color buttonColor;
  
  State createState () => new LevelPageState();
}

class LevelPageState extends State<LevelPage>{
  var pageItems;
  var pageColor;

  Widget _buildPageView() {
    String theme = widget.prefs.getString("theme");
    print(widget.levelCheck);
    if(widget.levelCheck == false){
      pageItems = category;
    }
    else{
        switch(widget.difficulty) {
          case("easy"):
            pageItems = easyItems;
            break;
          case("medium"):
            pageItems = mediumItems;
            break;
          case("hard"):
            pageItems = hardItems;
            break;
        }
      }
      return PageTransformer(
          pageViewBuilder: (context, visibilityResolver){
            return PageView.builder(
                itemCount: pageItems.length,
                controller: PageController(viewportFraction: 0.85),
                itemBuilder: (context, index){
                  final item = pageItems[index];
                  final pageVisibility = visibilityResolver.resolvePageVisibility(index);
                  return new InkWell(
                    onTap: ()=> pageRedirect(context: context, prefs: widget.prefs,
                        difficulty: item.difficulty, level: item.level, levelCheck: widget.levelCheck,
                        buttonColor: widget.buttonColor),
                    child: LevelPageItem(
                      item: item,
                      pageVisibility: pageVisibility,
                      level: widget.levelCheck,
                      pageColor: getColor(theme, (index+1).toString())
                    ),
                  );
                });
            },
        );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: ScaffoldBottomAppBar(
        parentContext: context,
        buttonColor: widget.buttonColor,
        prefs: widget.prefs,
        curPage: 'level',
    ),
      body: Center(
        child: SizedBox(
          height: 300.0,
            child: _buildPageView()
        ) ,
      ),
    );
  }
}