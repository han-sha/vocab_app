import 'package:flutter/material.dart';

import '../pages/color_palette.dart';

class ColorStripe extends StatefulWidget {
  ColorStripe({
    @required this.color,
    @required this.parent
  });

  final Color color;
  ColorPaletteState parent;
  ColorPaletteState get getParent => parent;

  @override
  State createState() => new ColorStripeState();
}


class ColorStripeState extends State<ColorStripe>{

  void _selected() {
        this.setState((){
          this.widget.parent.setState((){
            widget.parent.selected = widget.color;
          });
        });
  }

  BoxDecoration _setBorder() {
    var rst;
    if(widget.parent.selected == widget.color){
        rst = const BoxDecoration( border: const Border(
            top: const BorderSide(width: 9.0, color: Colors.black),
            left: const BorderSide(width: 9.0, color: Colors.black),
            right: const BorderSide(width: 9.0, color: Colors.black),
            bottom: const BorderSide(width: 9.0, color: Colors.black)));
    }else{
      rst = BoxDecoration( border: Border(
          top: BorderSide(width: 6.0, color: widget.color),
          left: BorderSide(width: 6.0, color: widget.color),
          right: BorderSide(width: 6.0, color: widget.color),
          bottom: BorderSide(width: 6.0, color: widget.color)));
    }

    return rst;
  }

    @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        decoration: _setBorder(),
        child: new Material(
          color: widget.color,
          child: new InkWell(
            onTap: _selected
          ),
        ),
      ),
    );
  }
}
