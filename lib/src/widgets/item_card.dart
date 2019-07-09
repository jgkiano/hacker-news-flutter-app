import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:share/share.dart';
import '../models/item.dart';
import '../models/item_image.dart';
import './color_item_card.dart';
import './normal_item_card.dart';
import './expanded_item_card.dart';

class ItemCard extends StatefulWidget {
  final Item item;
  final bool loading;

  ItemCard({this.item, this.loading = false});

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  double _opacity = 0.1;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    if (widget.loading == false) {
      if (widget.item.image == null) {
        return new ColorCard(
          item: widget.item,
          onTap: () => handleCardTap(widget.item),
          onShare: () => handleShareTap(widget.item),
        );
      } else if (widget.item.image.type == ItemImageType.expanded) {
        return new ExpandedItemCard(
          item: widget.item,
          onTap: () => handleCardTap(widget.item),
          onShare: () => handleShareTap(widget.item),
        );
      } else {
        return new NormalItemCard(
          item: widget.item,
          onTap: () => handleCardTap(widget.item),
          onShare: () => handleShareTap(widget.item),
        );
      }
    } else {
      return buildLoaderCard(context);
    }
  }

  Widget buildLoaderCard(BuildContext context) {
    _timer = new Timer(Duration(milliseconds: 700), () {
      if (_timer != null) {
        setState(() {
          _opacity = _opacity == 0.05 ? 0.1 : 0.05;
        });
      }
    });
    return AnimatedContainer(
      width: double.infinity,
      height: 175.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
        color: Colors.black.withOpacity(_opacity),
      ),
      margin: EdgeInsets.only(
        right: 5.0,
        left: 5.0,
        bottom: 16.0,
      ),
      duration: Duration(
        milliseconds: 700,
      ),
      curve: Curves.easeInOut,
    );
  }

  void handleCardTap(Item item) async {
    try {
      await launch(
        item.url,
        option: new CustomTabsOption(
          toolbarColor: Colors.black87,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: null,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void handleShareTap(Item item) {
    final String message =
        "${item.url} \n\nFor more tech news download TechStories App on Google Play Store";
    Share.share(message);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}
