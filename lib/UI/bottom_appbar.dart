import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_app/UI/exit_alert.dart';
import 'package:vocab_app/helpers/page_redirect.dart';

ScaffoldBottomAppBar({
  BuildContext parentContext,
  Color buttonColor,
  SharedPreferences prefs,
  String curPage,
}) {
  return Container(
    height: 50.0,
    child: BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => homePageDirect(
                  context: parentContext,
                  page: curPage,
                ),
            icon: Icon(
              Icons.home,
              size: 26.0,
              color: buttonColor,
            ),
          ),
          IconButton(
            onPressed: () => searchPageDirect(
                  context: parentContext,
                  prefs: prefs,
                  buttonColor: buttonColor,
                ),
            icon: Icon(
              Icons.search,
              size: 26.0,
              color: buttonColor,
            ),
          ),
          IconButton(
            onPressed: () => settingDirect(
                  context: parentContext,
                ),
            icon: Icon(
              Icons.settings,
              size: 26.0,
              color: buttonColor,
            ),
          ),
        ],
      ),
    ),
  );
}
