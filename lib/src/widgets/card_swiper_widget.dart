import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  final double height;

  CardSwiper({@required this.movies, @required this.height});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        layout: SwiperLayout.TINDER,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: height,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              fadeInDuration: Duration(milliseconds: 500),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(movies[index].getImgPoster()),
              fit: BoxFit.cover,
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
