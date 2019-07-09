import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:math';
import '../models/item.dart';

class ColorCard extends StatelessWidget {
  final Item item;
  final Function onTap;
  final Function onShare;

  ColorCard({@required this.item, this.onTap, this.onShare});

  final List<Color> colors = [
    Color.fromRGBO(136, 14, 79, 1),
    Color.fromRGBO(174, 20, 140, 1),
    Color.fromRGBO(49, 27, 146, 1),
    Color.fromRGBO(26, 35, 126, 1),
    Color.fromRGBO(13, 71, 161, 1),
    Color.fromRGBO(1, 87, 155, 1),
    Color.fromRGBO(0, 96, 100, 1),
    Color.fromRGBO(0, 77, 64, 1),
    Color.fromRGBO(27, 94, 32, 1),
    Color.fromRGBO(51, 105, 30, 1),
    Color.fromRGBO(130, 119, 23, 1),
    Color.fromRGBO(245, 127, 23, 1),
    Color.fromRGBO(255, 111, 0, 1),
    Color.fromRGBO(38, 50, 56, 1),
    Color.fromRGBO(230, 81, 0, 1),
    Color.fromRGBO(191, 54, 12, 1),
    Color.fromRGBO(62, 39, 35, 1),
  ];
  final Random _random = new Random();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            buildListTile(),
            buildMetaSection(),
          ],
        ),
      ),
      elevation: 4.0,
      color: Colors.deepOrange.shade700,
    );
  }

  Widget buildMetaSection() {
    return Container(
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 15.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(child: buildMetaText()),
          IconButton(
            icon: Icon(Platform.isIOS ? CupertinoIcons.share : Icons.share),
            onPressed: onShare,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildMetaText() {
    return Text(
      '${item.points} points | ${item.commentCount} comments',
      style: TextStyle(
        color: Colors.white70,
        fontSize: 12.0,
      ),
    );
  }

  Widget buildListTile() {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildPostedDate(),
          buildTitle(),
        ],
      ),
      subtitle: buildSubtitle(),
    );
  }

  Widget buildPostedDate() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 5.0,
        top: 15.0,
      ),
      child: Text(
        'posted ${timeago.format(item.date)}',
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      item.title,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'NunitoSans',
        fontSize: 18.0,
      ),
    );
  }

  Widget buildSubtitle() {
    return Container(
      child: Text(
        'By ${item.author}',
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white70,
        ),
      ),
    );
  }

  Color fetchCardColor() {
    return colors[next(0, (colors.length - 1))];
  }

  int next(int min, int max) => min + _random.nextInt(max - min);
}
