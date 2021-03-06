import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie>? movies;
  final Function nextPage;

  MovieHorizontal({required this.movies, required this.nextPage});

  final _pageController = PageController(viewportFraction: 0.333);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: screenSize.height * .2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: movies!.length,
        itemBuilder: (context, index) => _card(context, movies![index]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    final card = Container(
      width: 100,
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterPath()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 120,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            movie.title!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () =>
          Navigator.pushNamed(context, 'movie_detail', arguments: movie),
    );
  }
}
