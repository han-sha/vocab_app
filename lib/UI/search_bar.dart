import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({
    @required this.controller,
    @required this.search,
//    @required this.handleSearchStart,
//    @required this.handleSearchEnd,
  });

  TextEditingController controller;
  Function search;
//  Function handleSearchStart;
//  Function handleSearchEnd;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin{
  AnimationController _paddingController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double halfWidth = constraints.maxWidth / 2 - 30.0;
      return TextField(
        controller: widget.controller,
          onChanged: widget.search,
          style: new TextStyle(
            height: 0.8,
            fontSize: 21.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIcon: Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: new Icon(Icons.search, color: Colors.black),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            hintText: "search",
          ),
      );
    });
  }
}
