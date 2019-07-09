import 'dart:async';

import 'package:flutter/material.dart';
import '../mixins/utils.dart';

class StoryChip extends StatefulWidget {
  final String label;
  final bool loading;

  StoryChip({this.label, this.loading = false});

  @override
  _StoryChipState createState() => _StoryChipState();
}

class _StoryChipState extends State<StoryChip> with Utils {
  double _opacity = 0.2;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    if (widget.loading == false) {
      return Container(
        margin: EdgeInsets.only(
          right: screenAwareSize(10.0, context),
          left: screenAwareSize(10.0, context),
        ),
        child: Chip(
          label: Text(widget.label),
          onDeleted: () {},
        ),
      );
    }
    return buildLoader(context);
  }

  Widget buildLoader(BuildContext context) {
    _timer = new Timer(Duration(milliseconds: 600), () {
      if (_timer != null) {
        setState(() {
          _opacity = _opacity == 0.05 ? 0.1 : 0.05;
        });
      }
    });
    return AnimatedContainer(
      width: 80.0,
      height: 30.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Colors.black.withOpacity(_opacity),
      ),
      margin: EdgeInsets.only(
        right: 10.0,
        left: 10.0,
      ),
      duration: Duration(
        milliseconds: 500,
      ),
    );
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
