import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final moviesProvider = MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
        child: Container(
      height: 300,
      width: 300,
      color: Colors.indigoAccent,
      child: Text(query),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;

          return ListView(
              children: movies.map((movie) {
            final movieOverview = movie.overview;
            movie.uniqueId = '${movie.id}-search';

            return ListTile(
              leading: Hero(
                tag: movie.uniqueId,
                child: FadeInImage(
                  image: NetworkImage(movie.getPosterPath()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50,
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(movie.title),
              subtitle: Text(
                movieOverview.isEmpty ? 'No overview' : movieOverview,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontStyle: movieOverview.isEmpty
                        ? FontStyle.italic
                        : FontStyle.normal),
              ),
              onTap: () {
                close(context, null);
                Navigator.pushNamed(context, 'movie_detail', arguments: movie);
              },
            );
          }).toList());
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);
}
