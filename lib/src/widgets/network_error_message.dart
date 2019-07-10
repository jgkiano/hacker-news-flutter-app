import 'package:flutter/material.dart';

class NetWorkErrorMessage extends StatelessWidget {
  final Function onRetry;

  NetWorkErrorMessage({this.onRetry});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 15.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Hmm...',
                  textAlign: TextAlign.center,
                  style: titleStyle,
                ),
                Text(
                  'something went wrong.',
                  textAlign: TextAlign.center,
                  style: titleStyle,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 15.0,
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Looks link you lost your internet connection. Please check it and try again.',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          Container(
            child: OutlineButton(
              child: Text('Try again'),
              onPressed: onRetry ?? null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
            ),
          )
        ],
      ),
    );
  }
}
