import 'package:flutter/material.dart';
import './news_child_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: NewsChildScreen()),
    );
  }
}
