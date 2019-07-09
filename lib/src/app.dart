import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import './blocs/items_bloc.dart';
import './blocs/settings_bloc.dart';
import 'screens/home_screen.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SettingsBloc>(context);

    return StreamBuilder(
      stream: bloc.currentTheme,
      builder: (context, AsyncSnapshot<int> snapshot) {
        final lightTheme = ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepOrange,
          highlightColor: Colors.deepOrange.shade300.withOpacity(0.3),
          splashColor: Colors.deepOrange.shade500,
        );
        final darkTheme = ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepOrange,
          highlightColor: Colors.deepOrange.shade300.withOpacity(0.3),
          splashColor: Colors.deepOrange.shade500,
        );
        if (snapshot.data == 0) {
          toggleStatusBarColor(theme: 0);
          return MaterialApp(
            onGenerateRoute: routes,
            theme: darkTheme,
          );
        } else {
          toggleStatusBarColor(theme: 1);
          return MaterialApp(
            onGenerateRoute: routes,
            theme: lightTheme,
          );
        }
      },
    );
  }

  Route routes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) {
        return HomeScreen();
      },
    );
  }

  void toggleStatusBarColor({int theme = 1}) {
    final Color dark = Color.fromRGBO(33, 33, 33, 1);
    final Color light = Color.fromRGBO(238, 238, 238, 1);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: theme == 1 ? light : dark,
        statusBarIconBrightness:
            theme == 1 ? Brightness.dark : Brightness.light,
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ItemsBloc>(
          builder: (BuildContext context) => ItemsBloc(),
          dispose: (BuildContext context, value) => value.dispose(),
        ),
        Provider<SettingsBloc>(
          builder: (BuildContext context) => SettingsBloc(),
          dispose: (BuildContext context, value) => value.dispose(),
        ),
      ],
      child: AppWidget(),
    );
  }
}
