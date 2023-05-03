import 'package:flutter/material.dart';
import 'package:vocab_app/UI/palette_colors.dart';

class ButtonOverlay extends StatelessWidget{
  Color overlayColor;

  ButtonOverlay({
    this.overlayColor = transparent,
});

  @override
  Widget build(BuildContext context){
    return new Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: overlayColor,
      ),
    );
  }
}