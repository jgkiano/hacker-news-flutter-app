import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Map<String, dynamic> DEFAULT_SETTINGS = {
  "currentTheme": 1,
  "pushNotificationSubscription": false
};

class SettingsBloc {
  final _currentTheme = BehaviorSubject<int>();
  final _pushNotificationSubscription = BehaviorSubject<bool>();
  SharedPreferences _prefs;

  SettingsBloc() {
    // load the default theme
    _currentTheme.sink.add(DEFAULT_SETTINGS["currentTheme"]);

    // load the default push notification subscription
    _pushNotificationSubscription.sink
        .add(DEFAULT_SETTINGS["pushNotificationSubscription"]);

    _loadSavedSettings();
  }

  Observable<int> get pushNotificationSubscription => _currentTheme.stream;

  Observable<int> get currentTheme => _currentTheme.stream;

  Future _loadSavedSettings() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      int currentTheme =
          _prefs.getInt("currentTheme") ?? DEFAULT_SETTINGS["currentTheme"];
      bool pushNotificationSubscription =
          _prefs.getBool("pushNotificationSubscription") ??
              DEFAULT_SETTINGS["pushNotificationSubscription"];
      if (currentTheme != _currentTheme.value) {
        _currentTheme.sink.add(currentTheme);
      }
      if (pushNotificationSubscription != _pushNotificationSubscription.value) {
        _pushNotificationSubscription.sink.add(pushNotificationSubscription);
      }
    } catch (e) {} finally {
      print("settings loaded");
    }
  }

  void toggleTheme() {
    final int newValue = _currentTheme.value == 1 ? 0 : 1;
    _currentTheme.sink.add(newValue);
    if (_prefs != null) {
      _prefs
          .setInt("currentTheme", newValue)
          .then((_) => print("theme setting saved: $_"))
          .catchError((_) => print("error saving theme"));
    }
  }

  void togglePushNotificationSubscription() {
    final bool newValue =
        _pushNotificationSubscription.value == false ? true : false;
    _pushNotificationSubscription.sink.add(newValue);
    if (_prefs != null) {
      _prefs
          .setBool("pushNotificationSubscription", newValue)
          .then((_) => print("pushNotificationSubscription setting saved: $_"))
          .catchError(
              (_) => print("error saving pushNotificationSubscription"));
    }
    //TODO: add backend to update push notification
  }

  dispose() {
    _currentTheme.close();
  }
}
