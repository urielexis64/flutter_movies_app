import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/search/search_delegate.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopulars();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Billboard Movies'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[_swiperCards(), _footer(context)],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data!,
          );
        } else {
          return Container(
              height: 400, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Populars',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            StreamBuilder(
                stream: moviesProvider.popularsStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return MovieHorizontal(
                      movies: snapshot.data,
                      nextPage: moviesProvider.getPopulars,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ));
  }
}
