import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_app/helpers/page_redirect.dart';
import 'package:vocab_app/helpers/setcolors_helper.dart';
import 'package:vocab_app/radial_menu/anchored_radial_menu.dart';
import 'package:vocab_app/radial_menu/menu_items.dart';

Widget buildRadialMenu({
  BuildContext context,
  SharedPreferences prefs,
  List wordList,
  String curPage,
  bool showOverlay,
}) {
  String theme;
  if(prefs != null) theme = prefs.getString("theme");
  else theme = 'none';
  final Color openBubbleColor = getOpenBubbleColor(theme);
  final Color expandedBubbleColor = getExpandedBubbleColor(theme);
  if (MediaQuery.of(context).viewInsets.bottom == 0) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnchoredRadialMenu(
        showOverlay: showOverlay,
          menu: demoMenu,
          openBubbleColor: openBubbleColor,
          expandedBubbleColor: expandedBubbleColor,
          onSelected: (String menuItemId) {
            switch (menuItemId) {
              case ("3"):
                if (curPage != 'search')
                  searchPageDirect(
                    context: context,
                    prefs: prefs,
                  );
                break;
              case ("4"):
                if (curPage != 'home')
                  homePageDirect(context: context);
                break;
            }
          },
          child: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Color(0x00000000),
            ),
            onPressed: () {},
          )),
    );
  }else return Container();
}
