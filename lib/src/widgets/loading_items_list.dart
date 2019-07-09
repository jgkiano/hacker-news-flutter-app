import 'package:flutter/material.dart';
import './item_card.dart';

class LoadingItemsList extends StatelessWidget {
  final Widget topSection;

  const LoadingItemsList({@required this.topSection});

  @override
  Widget build(BuildContext context) {
    final int max = 10;
    final List<Widget> loadingCards = [];

    while (loadingCards.length < max) {
      loadingCards.add(
        Container(
          margin: EdgeInsets.only(
            left: 7.0,
            right: 7.0,
          ),
          child: ItemCard(
            loading: true,
          ),
        ),
      );
    }

    return ListView(
      children: <Widget>[
        topSection,
        ...loadingCards,
      ],
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
