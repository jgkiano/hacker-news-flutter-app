import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/top_header.dart';
import '../widgets/loading_items_list.dart';
import '../widgets/item_list.dart';
import '../widgets/item_list_spinner.dart';
import '../widgets/network_error_message.dart';
import '../blocs/items_bloc.dart';
import '../blocs/settings_bloc.dart';
import '../models/item.dart';
import '../models/settings_contant.dart';

class NewsChildScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemsBloc = Provider.of<ItemsBloc>(context);
    final settingsBloc = Provider.of<SettingsBloc>(context);
    return buildNewsScreen(itemsBloc, settingsBloc);
  }

  Widget buildNewsScreen(ItemsBloc itemsBloc, SettingsBloc settingsBloc) {
    return StreamBuilder(
      stream: itemsBloc.items,
      builder: (_, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.hasError) {
          return NetWorkErrorMessage(
            onRetry: itemsBloc.retryFetchItems,
          );
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return LoadingItemsList(
            topSection: buildTopSection(itemsBloc, settingsBloc),
          );
        }
        return ItemsList(
          items: snapshot.data,
          onScrollBottom: itemsBloc.fetchMoreItems,
          topSection: buildTopSection(itemsBloc, settingsBloc),
          bottomSection: buildBottomSpinner(itemsBloc),
          onRefresh: itemsBloc.refreshItems,
        );
      },
    );
  }

  Widget buildBottomSpinner(ItemsBloc itemsBloc) {
    return StreamBuilder(
      stream: itemsBloc.isFetchingMoreItems,
      builder: (_, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) return ItemListSpinner();
        return Container(
          height: 0,
          width: 0,
        );
      },
    );
  }

  Widget buildTopSection(ItemsBloc itemsBloc, SettingsBloc settingsBloc) {
    return StreamBuilder(
      stream: itemsBloc.topic,
      builder: (BuildContext context, AsyncSnapshot<String> itemsSnapshot) {
        final String title = itemsSnapshot.data ?? "";
        return StreamBuilder(
          stream: settingsBloc.currentTheme,
          builder: (_, AsyncSnapshot<int> settingsSnapshot) {
            return TopHeader(
              title: title,
              onFilterPress: () => bottomSheet(context, itemsBloc),
              onSettingSelection: (String choice) {
                if (choice == SettingsConstant.DarkMode ||
                    choice == SettingsConstant.LightMode) {
                  return settingsBloc.toggleTheme();
                }
                if (choice == SettingsConstant.About) {
                  return print("Kiano is awesome");
                }
              },
              settings: generateSettings(settingsSnapshot),
            );
          },
        );
      },
    );
  }

  List<String> generateSettings(AsyncSnapshot<int> settingsSnapshot) {
    final isLightMode = !settingsSnapshot.hasData ||
            settingsSnapshot.hasError ||
            settingsSnapshot.data == 1
        ? true
        : false;
    return SettingsConstant.choices.where((String choice) {
      if (isLightMode && choice != SettingsConstant.LightMode) {
        return true;
      }
      if (!isLightMode && choice != SettingsConstant.DarkMode) {
        return true;
      }
      if (choice != SettingsConstant.DarkMode &&
          choice != SettingsConstant.LightMode) {
        return true;
      }
      return false;
    }).toList();
  }

  void bottomSheet(BuildContext context, ItemsBloc itemsBloc) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return StreamBuilder(
          stream: itemsBloc.topic,
          builder: (context, AsyncSnapshot<String> snapshot) {
            final activeIcon = Icon(
              Icons.check_circle,
              color: Colors.deepOrange.shade700,
            );
            final normalIcon = Icon(Icons.check_circle_outline);
            if (snapshot.hasData) {
              return Container(
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      leading:
                          snapshot.data == 'Stories' ? activeIcon : normalIcon,
                      title: Text('Stories'),
                      onTap: () =>
                          onBottomSheetSelect(bc, 'Stories', itemsBloc),
                    ),
                    ListTile(
                      leading:
                          snapshot.data == 'Jobs' ? activeIcon : normalIcon,
                      title: Text('Jobs'),
                      onTap: () => onBottomSheetSelect(bc, 'Jobs', itemsBloc),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }

  void onBottomSheetSelect(
      BuildContext context, String selection, ItemsBloc bloc) {
    bloc.changeTopic(selection);
    Navigator.pop(context);
  }

  void handleSettingSelection(String choice) {}
}
