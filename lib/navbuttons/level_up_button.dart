import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_app/helpers/page_redirect.dart';
import 'package:vocab_app/pages/level_page.dart';

class LevelUpButton extends StatefulWidget {
  LevelUpButton({
    @required this.pageContext,
    @required this.buttonColor,
    @required this.prefs,
});
  Color buttonColor;
  SharedPreferences prefs;
  BuildContext pageContext;

  @override
  _LevelUpButtonState createState() => _LevelUpButtonState();
}

class _LevelUpButtonState extends State<LevelUpButton>
    with SingleTickerProviderStateMixin {
  AnimationController _sizeController;
  AnimationController _alignController;

  @override
  void initState() {
    super.initState();
    _sizeController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        this.setState(() {});
      });

//    _alignController = AnimationController(
//      duration: const Duration(milliseconds: 1000), vsync: this)
//    ..repeat()
//    )

    _sizeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0 * Curves.bounceInOut.transform(_sizeController.value),
      height: 90.0 * Curves.bounceInOut.transform(_sizeController.value),
      child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          elevation: 6.0),
          onPressed: ()=> levelPageRedirect(
              context: widget.pageContext,
              prefs: widget.prefs,
              buttonColor: widget.buttonColor,
          ),
          child: Text(
            "Level Up",
            style: TextStyle(
              fontSize: 26.0 * Curves.bounceInOut.transform(_sizeController.value),
              color: Colors.white,
              letterSpacing: 3.0,
            ),
          ),
      ),
    );
  }

  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }
}
