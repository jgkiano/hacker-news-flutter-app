import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/item.dart';
import '../mixins/utils.dart';

class NormalItemCard extends StatelessWidget with Utils {
  final Item item;
  final Function onTap;
  final Function onShare;

  NormalItemCard({@required this.item, this.onTap, this.onShare});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: buildListTile(),
                  ),
                ),
                buildImageContainer(context)
              ],
            ),
            buildMetaSection(),
          ],
        ),
      ),
      elevation: 4.0,
    );
  }

  Widget buildImageContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 15.0,
      ),
      child: ClipRRect(
        child: Container(
          height: screenAwareSize(80, context),
          width: screenAwareSize(80, context),
          decoration: BoxDecoration(
            color: Colors.black12,
          ),
          child: Image.network(
            item.image.url,
            fit: BoxFit.cover,
          ),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
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
          ),
        ],
      ),
    );
  }

  Widget buildMetaText() {
    return Text(
      '${item.points} points | ${item.commentCount} comments',
      style: TextStyle(
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
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Text(
      item.title,
      style: TextStyle(
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
        ),
      ),
    );
  }
}
