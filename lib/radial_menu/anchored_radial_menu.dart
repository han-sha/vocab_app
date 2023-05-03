import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocab_app/radial_menu/colliding_radial_menu.dart';
import 'package:vocab_app/radial_menu/geometry.dart';
import 'package:vocab_app/radial_menu/layout_overlays.dart';
import 'package:vocab_app/radial_menu/menu_items.dart';

class AnchoredRadialMenu extends StatefulWidget {
  final Menu menu;
  final double radius;
  final double startAngle;
  final double endAngle;
  final Widget child;
  final Function(String menuItemId) onSelected;
  final Color openBubbleColor;
  final Color expandedBubbleColor;
  final bool showOverlay;

  AnchoredRadialMenu({
    this.openBubbleColor,
    this.expandedBubbleColor,
    this.menu,
    this.child,
    this.onSelected,
    this.radius = 75.0,
    this.startAngle = -pi / 2,
    this.endAngle = 3 * pi / 2,
    this.showOverlay,
  });

  @override
  _AnchoredRadialMenuState createState() => _AnchoredRadialMenuState();
}

class _AnchoredRadialMenuState extends State<AnchoredRadialMenu> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnchoredOverlay(
      showOverlay: widget.showOverlay,
      child: widget.child,
      overlayBuilder: (BuildContext context, Rect rect, Offset anchor) {
        return CollidingRadialMenu(
          anchor: anchor,
          menu: widget.menu,
          radius: widget.radius,
          arc: Arc(
            from: Angle.fromRadians(widget.startAngle),
            to: Angle.fromRadians(widget.endAngle),
            direction: RadialDirection.clockwise,
          ),
          onSelected: widget.onSelected,
          openBubbleColor: widget.openBubbleColor,
          expandedBubbleColor: widget.expandedBubbleColor,
        );
      },
    );
  }
}
