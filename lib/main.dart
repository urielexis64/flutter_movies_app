import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: '/',
      routes: {'/': (BuildContext context) => HomePage()},
    );
  }
}
