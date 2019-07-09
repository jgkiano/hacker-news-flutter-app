import 'dart:async';

import 'package:flutter/material.dart';
import '../mixins/utils.dart';

class StoryChipsTitle extends StatefulWidget {
  final String text;
  final bool loading;

  StoryChipsTitle({@required this.text, this.loading = false});

  @override
  _StoryChipsTitleState createState() => _StoryChipsTitleState();
}

class _StoryChipsTitleState extends State<StoryChipsTitle> with Utils {
  double _opacity = 0.2;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    if (widget.loading == false) {
      return Text(widget.text);
    }
    return buildLoader(context);
  }

  buildLoader(BuildContext context) {
    _timer = new Timer(Duration(milliseconds: 600), () {
      if (_timer != null) {
        setState(() {
          _opacity = _opacity == 0.05 ? 0.1 : 0.05;
        });
      }
    });
    return AnimatedContainer(
      width: screenAwareSize(90.0, context),
      height: screenAwareSize(17.0, context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Colors.black.withOpacity(_opacity),
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
