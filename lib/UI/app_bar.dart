import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_app/helpers/page_redirect.dart';

AppBar ScaffoldAppBar({
  BuildContext scaffoldContext,
  Color homePageButton,
  SharedPreferences prefs
}) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: InkWell(
            onTap: ()=> settingDirect(
              context: scaffoldContext,
            ),
            child: Icon(
              Icons.settings,
              color: homePageButton,
              size: 25.0,
            )
        ),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      elevation: 0.0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25.0),
          child: InkWell(
            onTap: ()=> searchPageDirect(
              context: scaffoldContext,
              prefs: prefs,
            ),
            child: Icon(
              Icons.search,
              color: homePageButton,
              size: 30.0,
            ),
          ),
        )
      ],
    );
  }
