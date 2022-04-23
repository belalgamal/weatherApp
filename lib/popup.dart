import 'package:flutter/material.dart';

class Pup {
  Widget buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Alert'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "check:\n 1-your internet connection.\n 2-open your location.\n3-try again!"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget buildCityPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Alert'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "check,please:\n1-internet connection and location.\n2-incorrect city name.\n3-try again!"),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
