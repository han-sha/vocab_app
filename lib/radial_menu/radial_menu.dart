///this section is entirely brought from the fluttery radial menu youtube course

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_dart2/animations.dart';
import 'package:fluttery_dart2/layout.dart';
import 'package:vocab_app/radial_menu/activation_painter.dart';
import 'package:vocab_app/radial_menu/geometry.dart';
import 'package:vocab_app/radial_menu/icon_bubble.dart';
import 'package:vocab_app/radial_menu/menu_items.dart';
import 'package:vocab_app/radial_menu/polar_position.dart';
import 'package:vocab_app/radial_menu/radial_menu_controller.dart';
import 'package:vocab_app/radial_menu/radial_menu_state.dart';

class RadialMenu extends StatefulWidget {
  final Color openBubbleColor;
  final Color expandedBubbleColor;
  final Menu menu;
  final Offset anchor;
  final double radius;
  final Arc arc;
  final Function(String menuItemId) onSelected;

  RadialMenu(
      {this.menu,
      this.anchor,
      this.openBubbleColor,
      this.expandedBubbleColor,
      this.radius = 75.0,
      this.arc = const Arc(
          from: Angle.fromRadians(-pi / 2),
          to: Angle.fromRadians(2 * pi - (pi / 2))),
      this.onSelected});

  @override
  _RadialMenuState createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  RadialMenuController _menuController;

  @override
  void initState() {
    super.initState();

    _menuController = RadialMenuController(
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..addSelectionListener(widget.onSelected);

    _menuController.open();
//    Timer(
//      Duration(milliseconds: 500),
//          (){
//        _menuController.open();
//      },
//    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _menuController.dispose();
    super.dispose();
  }

  Widget buildCenter() {
    IconData icon;
    Color bubbleColor;
    double scale = 1.0;
    double rotation = 0.0;
    VoidCallback onPressed;

    onPressed = () {
      _menuController.expand();
    };

    switch (_menuController.state) {
      case RadialMenuState.closed:
        icon = Icons.menu;
        bubbleColor = widget.openBubbleColor;
        scale = 0.0;
        break;
      case RadialMenuState.closing:
        icon = Icons.menu;
        bubbleColor = widget.openBubbleColor;
        scale = 1.0 - _menuController.progress;
        break;
      case RadialMenuState.opening:
        icon = Icons.menu;
        bubbleColor = widget.openBubbleColor;
        scale = Curves.elasticOut.transform(_menuController.progress);
        if (0.0 < _menuController.progress && _menuController.progress < 0.5) {
          rotation = lerpDouble(
            0.0,
            pi / 4,
            Interval(0.0, 0.5).transform(_menuController.progress),
          );
        } else {
          rotation = lerpDouble(
            pi / 4,
            0.0,
            Interval(0.5, 1.0).transform(_menuController.progress),
          );
        }
        break;
      case RadialMenuState.open:
        icon = Icons.menu;
        bubbleColor = widget.openBubbleColor;
        scale = 1.0;
        onPressed = () {
          _menuController.expand();
        };
        break;
      case RadialMenuState.expanding:
        icon = Icons.clear;
        bubbleColor = widget.expandedBubbleColor;
        scale = 1.0;
        rotation = Interval(0.0, 0.5, curve: Curves.easeOut)
                .transform(_menuController.progress) *
            (pi / 2);
        break;
      case RadialMenuState.collapsing:
        icon = Icons.clear;
        bubbleColor = widget.expandedBubbleColor;
        scale = 1.0;
        break;
      case RadialMenuState.expanded:
        icon = Icons.clear;
        bubbleColor = widget.expandedBubbleColor;
        scale = 1.0;
        onPressed = () {
          _menuController.collapse();
        };
        break;
      case RadialMenuState.activating:
        icon = Icons.clear;
        bubbleColor = widget.expandedBubbleColor;
        scale = lerpDouble(
          1.0,
          0.0,
          Interval(0.0, 0.9, curve: Curves.easeOut)
              .transform(_menuController.progress),
        );
        break;
      case RadialMenuState.dissipating:
        icon = Icons.menu;
        bubbleColor = widget.openBubbleColor;
        scale = lerpDouble(
            0.0, 1.0, Curves.elasticOut.transform(_menuController.progress));
        if (0.0 < _menuController.progress && _menuController.progress < 0.5) {
          rotation = lerpDouble(
            0.0,
            pi / 4,
            Interval(0.0, 0.5).transform(_menuController.progress),
          );
        } else {
          rotation = lerpDouble(
            pi / 4,
            0.0,
            Interval(0.5, 1.0).transform(_menuController.progress),
          );
        }
        break;
    }

    return CenterAbout(
      position: widget.anchor,
      child: Transform(
        transform: Matrix4.identity()
          ..scale(scale, scale)
          ..rotateZ(rotation),
        alignment: Alignment.center,
        child: IconBubble(
          diameter: 50.0,
          icon: icon,
          iconColor: Colors.black,
          bubbleColor: bubbleColor,
          onPressed: onPressed,
        ),
      ),
    );
  }

  List<Widget> buildRadialBubbles() {
    final Angle startAngle = widget.arc.from;
    final Angle sweepAngle = widget.arc.to - startAngle;
    int index = 0;
    int itemCount = widget.menu.items.length;

    return widget.menu.items.map((MenuItem item) {
      final int indexDivisor =
          sweepAngle == Angle.fullCircle ? itemCount : itemCount - 1;
      final Angle myAngle = startAngle + (sweepAngle * (index / indexDivisor));
      ++index;

      if ((_menuController.state == RadialMenuState.activating ||
              _menuController.state == RadialMenuState.dissipating) &&
          _menuController.activationId == item.id) {
        return Container();
      }

      return buildRadialBubble(
        id: item.id,
        icon: item.icon,
        iconColor: item.iconColor,
        bubbleColor: item.bubbleColor,
        angle: myAngle.toRadians(),
      );
    }).toList(growable: true);
  }

  Widget buildRadialBubble({
    String id,
    IconData icon,
    Color iconColor,
    Color bubbleColor,
    double angle,
  }) {
    if (_menuController.state == RadialMenuState.closed ||
        _menuController.state == RadialMenuState.closing ||
        _menuController.state == RadialMenuState.opening ||
        _menuController.state == RadialMenuState.open ||
        _menuController.state == RadialMenuState.dissipating) {
      return Container();
    }

    double radius = widget.radius;
    double scale = 1.0;

    if (_menuController.state == RadialMenuState.expanding) {
      radius =
          widget.radius * Curves.elasticOut.transform(_menuController.progress);
      scale = lerpDouble(
          0.3,
          1.0,
          Interval(0.0, 0.3, curve: Curves.easeOut)
              .transform(_menuController.progress));
    } else if (_menuController.state == RadialMenuState.collapsing) {
      radius = widget.radius * (1.0 - _menuController.progress);
      scale = lerpDouble(0.3, 1.0, (1.0 - _menuController.progress));
    }

    return PolarPosition(
        origin: widget.anchor,
        coord: PolarCoord(angle, radius),
        child: Transform(
          transform: Matrix4.identity()..scale(scale, scale),
          alignment: Alignment.center,
          child: IconBubble(
              diameter: 50.0,
              icon: icon,
              iconColor: iconColor,
              bubbleColor: bubbleColor,
              onPressed: () {
                _menuController.activate(id);
              }),
        ));
  }

  Widget buildActivationRibbon() {
    if (_menuController.state != RadialMenuState.activating &&
        _menuController.state != RadialMenuState.dissipating) {
      return Container();
    }

    final MenuItem activeItem = widget.menu.items
        .firstWhere((MenuItem item) => item.id == _menuController.activationId);
    final int activeIndex = widget.menu.items.indexOf(activeItem);
    final itemCount = widget.menu.items.length;

    Angle startAngle;
    Angle endAngle;
    double radius = widget.radius;
    double opacity = 1.0;
    if (_menuController.state == RadialMenuState.activating) {
//      startAngle = - pi / 2 + (activeIndex * 2 * pi / widget.menu.items.length);
//      endAngle = (2 * pi) * _menuController.progress + startAngle;
      final Angle menuSweepAngle = widget.arc.sweepAngle();
      final double indexDivisor = menuSweepAngle == Angle.fullCircle
          ? itemCount.toDouble()
          : (itemCount - 1).toDouble();
      final Angle initialItemAngle = widget.arc.from +
          (menuSweepAngle * (activeIndex.toDouble() / indexDivisor));

      if (menuSweepAngle == Angle.fullCircle) {
        startAngle = initialItemAngle;
        endAngle =
            initialItemAngle + (menuSweepAngle * _menuController.progress);
      } else {
        startAngle = initialItemAngle -
            ((initialItemAngle - widget.arc.from) * _menuController.progress);
        endAngle = initialItemAngle +
            ((widget.arc.to - initialItemAngle) * _menuController.progress);
      }
    } else if (_menuController.state == RadialMenuState.dissipating) {
      startAngle = widget.arc.from;
      endAngle = widget.arc.to;

      final adjustedProgress =
          Interval(0.0, 0.5).transform(_menuController.progress);
      radius = widget.radius * (1.0 + 0.25 * adjustedProgress);
      opacity = 1.0 - adjustedProgress;
    }

    return CenterAbout(
        position: widget.anchor,
        child: Opacity(
          opacity: opacity,
          child: CustomPaint(
              painter: ActivationPainter(
                  radius: radius,
                  color: activeItem.bubbleColor,
                  startAngle: startAngle.toRadians(),
                  endAngle: endAngle.toRadians(),
                  thickness: 50.0)),
        ));
  }

  Widget buildActivationBubble() {
    if (_menuController.state != RadialMenuState.activating) {
      return Container();
    }

    final MenuItem activeItem = widget.menu.items
        .firstWhere((MenuItem item) => item.id == _menuController.activationId);
    final int activeIndex = widget.menu.items.indexOf(activeItem);
    final int itemCount = widget.menu.items.length;

    final Angle sweepAngle = widget.arc.sweepAngle();
    final double indexDivisor = sweepAngle == Angle.fullCircle
        ? itemCount.toDouble()
        : (itemCount - 1).toDouble();
    final Angle initialItemAngle =
        widget.arc.from + (sweepAngle * (activeIndex / indexDivisor));
    //final double startAngle = - pi / 2 + (activeIndex * 2 * pi / widget.menu.items.length);
    //final double currAngle = (2 * pi) * _menuController.progress + startAngle;

    Angle currAngle;
    if (sweepAngle == Angle.fullCircle) {
      currAngle = (sweepAngle * _menuController.progress) + initialItemAngle;
    } else {
      final double centerAngle = lerpDouble(
          widget.arc.from.toRadians(), widget.arc.to.toRadians(), 0.5);
      currAngle = Angle.fromRadians(lerpDouble(
          initialItemAngle.toRadians(), centerAngle, _menuController.progress));
    }

    return buildRadialBubble(
      id: activeItem.id,
      icon: activeItem.icon,
      iconColor: activeItem.iconColor,
      bubbleColor: activeItem.bubbleColor,
      angle: currAngle.toRadians(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return Stack(
        children: buildRadialBubbles()
          ..addAll(
            [
              buildCenter(),
              buildActivationRibbon(),
              buildActivationBubble(),
            ],
          ),
      );
  }
}
