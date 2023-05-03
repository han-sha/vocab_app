import 'package:flutter/material.dart';


class LoadingCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.white,
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(backgroundColor: Colors.white)
            ]
        )
    );
  }
}