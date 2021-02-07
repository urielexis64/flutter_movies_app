import 'package:flutter/material.dart';
import 'package:movies/src/pages/actor_detail.dart';
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
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
      onGenerateRoute: (settings) {
        Route route;
        switch (settings.name) {
          case 'movie_detail':
            route = transitionPage(MovieDetail(), 500, settings);
            break;
          case 'actor_detail':
            route = transitionPage(ActorDetail(), 500, settings);
            break;
        }
        return route;
      },
    );
  }

  Route<dynamic> transitionPage(
      Widget widget, int duration, RouteSettings settings) {
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation1, animation2) =>
            FadeTransition(opacity: animation1, child: widget),
        transitionDuration: Duration(milliseconds: duration),
        reverseTransitionDuration: Duration(milliseconds: duration));
  }
}
