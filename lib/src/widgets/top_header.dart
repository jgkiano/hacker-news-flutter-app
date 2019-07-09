import 'package:flutter/material.dart';
import './title_text.dart';

class TopHeader extends StatelessWidget {
  final String title;
  final Function onFilterPress;
  final Function(String setting) onSettingSelection;
  final List<String> settings;

  const TopHeader({
    @required this.title,
    this.onFilterPress,
    this.onSettingSelection,
    @required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 16.0,
        left: 10.0,
        right: 10.0,
        bottom: 16.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TitleText(title),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: onFilterPress,
                alignment: Alignment.centerRight,
              ),
              PopupMenuButton<String>(
                onSelected: onSettingSelection,
                itemBuilder: (BuildContext context) {
                  return settings.map((String setting) {
                    return PopupMenuItem<String>(
                      value: setting,
                      child: Text(setting),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  handleSettingSelection(String choice) {}
}
