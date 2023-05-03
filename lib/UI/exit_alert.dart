import 'package:flutter/material.dart';

Future<bool> exitAlertBox(BuildContext context){
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(
          'are you sure?'
        ),
        actions: [
          FlatButton(
            child: Text('YES'),
            onPressed: ()=> Navigator.of(context).pop(true),
          ),
          FlatButton(
            child: Text('NO'),
            onPressed: ()=> Navigator.of(context).pop(false),
          )
        ],
      );
    });
}