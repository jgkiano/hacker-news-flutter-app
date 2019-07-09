import 'package:rxdart/rxdart.dart';

class SettingsBloc {
  final _currentTheme = BehaviorSubject<int>();

  SettingsBloc() {
    _currentTheme.sink.add(1);
  }

  Observable<int> get currentTheme => _currentTheme.stream;

  Function get toggleTheme =>
      () => _currentTheme.sink.add(_currentTheme.value == 1 ? 0 : 1);

  dispose() {
    _currentTheme.close();
  }
}
