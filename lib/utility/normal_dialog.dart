import 'package:flutter/material.dart';

//format dialog
//buildcontext คือการต่อท่อเรียกข้อมูลมา Show
Future<void> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      });
}
