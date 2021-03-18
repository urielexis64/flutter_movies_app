import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({required this.movies});

  //
  //

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return CarouselSlider.builder(
        itemCount: movies.length,
        itemBuilder: (context, index, realIndex) =>
            MoviePosterImage(movie: movies[index]),
        options: CarouselOptions(
            aspectRatio: 2.0, enlargeCenterPage: true, autoPlay: true));
  }
}

class MoviePosterImage extends StatelessWidget {
  const MoviePosterImage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, 'movie_detail', arguments: movie),
      child: Hero(
        tag: movie.uniqueIdBanner,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: FadeInImage(
            fadeInDuration: Duration(milliseconds: 500),
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(movie.getBackdropPath()),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
