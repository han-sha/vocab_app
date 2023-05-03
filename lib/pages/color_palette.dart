import 'package:flutter/material.dart';

import '../UI/palette_component.dart';
import '../UI/palette_colors.dart';

class ColorPalette extends StatefulWidget {
  @override
  State createState() => new ColorPaletteState();
}


class ColorPaletteState extends State<ColorPalette>{
  Color selected;
  @override
  void initState(){
    super.initState();
    selected = blue1;
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new ColorStripe(color: redPrimary1, parent: this),
            new ColorStripe(color: orangePrimary1, parent: this),
            new ColorStripe(color: yellowPrimary1, parent: this),
            new ColorStripe(color: greenPrimary1, parent: this),
            new ColorStripe(color: aquaPrimary1, parent: this),
            new ColorStripe(color: blue1, parent: this),
            new ColorStripe(color: purplePrimary1, parent: this),
            new ColorStripe(color: whitePrimary1, parent: this)
          ],
      ),
    );
  }
}