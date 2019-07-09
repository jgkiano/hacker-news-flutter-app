import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item.dart';
import './item_card.dart';

class ItemsList extends StatefulWidget {
  final List<Item> items;
  final Widget bottomSection;
  final Widget topSection;
  final Function onScrollBottom;
  final Future<void> Function() onRefresh;

  ItemsList({
    @required this.items,
    @required this.topSection,
    @required this.onRefresh,
    this.bottomSection,
    this.onScrollBottom,
  });

  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(_scrollListender);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> list = [
      widget.topSection,
      ...widget.items,
      widget.bottomSection,
    ];
    return WillPopScope(
      onWillPop: _onBackPress,
      child: RefreshIndicator(
        child: ListView.separated(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0 || index == (list.length - 1)) {
              return list[index];
            }
            return Container(
              margin: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: ItemCard(
                item: list[index],
                loading: false,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            if (index != 0) {
              return Container(height: 10.0);
            }
            return Container(height: 0);
          },
          controller: _scrollController,
        ),
        onRefresh: widget.onRefresh,
      ),
    );
  }

  Future<bool> _onBackPress() {
    final double currentScroll = _scrollController.position.pixels;
    if (currentScroll > 10) {
      _scrollController.animateTo(0,
          curve: Curves.easeInOut, duration: Duration(seconds: 1));
      return Future.value(false);
    }
    return Future.value(true);
  }

  _scrollListender() {
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;
    final double delta = 400.0;

    if (maxScroll - currentScroll <= delta && widget.onScrollBottom != null) {
      widget.onScrollBottom();
    }
  }

  Future _onWillPop(BuildContext context) {
    final double scrollAmount = 50;
    final double currentScroll = _scrollController.position.pixels;
    if (currentScroll > scrollAmount) {
      _scrollController.animateTo(
        5.0,
        curve: Curves.easeInOut,
        duration: Duration(
          seconds: 1,
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
    return Future.value();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListender);
    super.dispose();
  }
}
