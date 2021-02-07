import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        layout: SwiperLayout.TINDER,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          movies[index].uniqueId = '${movies[index].id}-card';

          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'movie_detail',
                      arguments: movies[index]);
                },
                child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: 500),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(movies[index].getPosterPath()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
        /* pagination: new SwiperPagination(),
        control: new SwiperControl(), */
      ),
    );
  }
}
