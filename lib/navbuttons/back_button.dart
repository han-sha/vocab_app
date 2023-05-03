import 'package:flutter/material.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_app/helpers/setcolors_helper.dart';
import 'package:vocab_app/radial_menu/icon_bubble.dart';

class BubbleBackButton extends StatefulWidget {
  BubbleBackButton({
    @required this.prefs,
    @required this.onPressed,
  });

  final SharedPreferences prefs;
  final Function onPressed;

  @override
  _BubbleBackButtonState createState() => _BubbleBackButtonState();
}

class _BubbleBackButtonState extends State<BubbleBackButton>
    with SingleTickerProviderStateMixin {
  AnimationController _sizeController;

  double scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sizeController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        this.setState(() {});
      });
    _sizeController.forward();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: IconBubble(
          icon: OpenIconicIcons.x,
          diameter: 50.0 * Curves.elasticOut.transform(_sizeController.value),
          iconColor: Colors.black,
          bubbleColor: getOpenBubbleColor(widget.prefs.getString("theme")),
          onPressed: widget.onPressed,
        ),
    );
  }

  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }
}
