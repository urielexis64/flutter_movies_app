import 'package:flutter/material.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Billboard Movies'),
        backgroundColor: Colors.indigoAccent,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Container(
        child: Column(
          children: <Widget>[_swiperCards()],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return CardSwiper(
      movies: [1, 2, 3, 4, 5],
    );
  }
}