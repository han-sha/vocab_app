import 'package:flutter/material.dart';

class Menu{
  final List<MenuItem> items;

  Menu({
    this.items,
  });
}


class MenuItem{
  final String id;
  final IconData icon;
  final Color iconColor;
  final Color bubbleColor;

  MenuItem({
    this.id,
    this.icon,
    this.iconColor,
    this.bubbleColor
  });
}

final Menu demoMenu = Menu(items: [
  new MenuItem(
      id: '1',
      icon: Icons.settings,
      iconColor: Colors.white,
      bubbleColor: Colors.purple
  ),
  new MenuItem(
      id: '2',
      icon: Icons.pie_chart,
      iconColor: Colors.white,
      bubbleColor: Colors.orange
  ),
  new MenuItem(
      id: '3',
      icon: Icons.search,
      iconColor: Colors.white,
      bubbleColor: Colors.red
  ),
  new MenuItem(
      id: '4',
      icon: Icons.home,
      iconColor: Colors.white,
      bubbleColor: Colors.blue
  ),
]
);