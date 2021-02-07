import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies/src/models/actors_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _titlePoster(movie, context),
                  _description(movie),
                  _createCasting(movie)
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 10,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        title: RichText(
          text: WidgetSpan(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color.fromRGBO(20, 20, 20, .8)),
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  //backgroundColor: Colors.blueAccent,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          )),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(movie.getBackdropPath()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _titlePoster(Movie movie, BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: movie.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: NetworkImage(movie.getPosterPath()),
              height: 140,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.subtitle2,
                  )
                ],
              ),
              _releaseDate(movie),
            ],
          ),
        )
      ],
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(movie.overview,
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.white, fontSize: 13)),
    );
  }

  Widget _createCasting(Movie movie) {
    final movieProvider = MoviesProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createPageViewActors(snapshot.data, context);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _createPageViewActors(List<Actor> actors, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Casting',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 14),
        SizedBox(
          height: 180,
          child: PageView.builder(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              controller: PageController(initialPage: 1, viewportFraction: .33),
              itemCount: actors.length,
              pageSnapping: false,
              itemBuilder: (context, index) {
                return _actorCard(actors[index]);
              }),
        ),
      ],
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      /* padding: EdgeInsets.symmetric(horizontal: 10), */
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/img/no-image.jpg'),
            image: NetworkImage(actor.getImgPoster()),
            height: 150,
            width: 90,
          ),
        ),
        SizedBox(height: 6),
        Text(
          actor.name,
          style: TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }

  Widget _releaseDate(Movie movie) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Release Date',
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            movie.releaseDate,
            style: TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }
}
