import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: '/',
      /* routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => MovieDetail()
      }, */
      onGenerateRoute: (settings) {
        Route route;
        switch (settings.name) {
          case 'detail':
            route = transitionPage(MovieDetail(), 500, settings);
            break;
          case '/':
            route = transitionPage(HomePage(), 500, settings);
            break;
          default:
            route = transitionPage(HomePage(), 500, settings);
        }
        return route;
      },
    );
  }

  Route<dynamic> transitionPage(
      Widget widget, int duration, RouteSettings settings) {
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) => widget,
        transitionDuration: Duration(milliseconds: duration),
        reverseTransitionDuration: Duration(milliseconds: duration));
  }
}
