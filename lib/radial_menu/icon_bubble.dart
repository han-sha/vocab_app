import 'package:flutter/material.dart';

class IconBubble extends StatelessWidget {

  final IconData icon;
  final double diameter;
  final Color iconColor;
  final Color bubbleColor;
  final Function onPressed;

  IconBubble({
    this.icon,
    this.diameter,
    this.iconColor,
    this.bubbleColor,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bubbleColor
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.0,),
            child: Icon(
                icon,
                color: iconColor,
                size: 20.0,
            ),
          )
      ),
    );
  }
}