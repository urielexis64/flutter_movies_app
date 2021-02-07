import 'package:flutter/material.dart';
import 'package:movies/src/models/person_model.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/background_text.dart';

import 'package:url_launcher/url_launcher.dart';

class ActorDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actorId = ModalRoute.of(context).settings.arguments;

    final MoviesProvider moviesProvider = MoviesProvider();
    return FutureBuilder(
      future: moviesProvider.getPerson(actorId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _createMainPage(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _createMainPage(Person person) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppBar(person),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [_createBiography(person)],
              ),
            )
          ]))
        ],
      ),
    );
  }

  Widget _createAppBar(Person person) {
    return SliverAppBar(
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 450,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        title: BackgroundText(
          text: person.name,
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(person.getImgPoster()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _createBiography(Person person) {
    return Container(
      child: Column(
        children: [
          _createHomepage(person),
          Container(
            alignment: Alignment.topLeft,
            child: Text('Biography',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            person.biography.isEmpty
                ? 'There\'s no info about this actor.'
                : person.biography,
            textAlign: TextAlign.justify,
          ),
          Divider(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget _createHomepage(Person person) {
    if (person.homepage != null) {
      return Column(
        children: [
          Text(
            'Homepage',
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            child: Text('${person.homepage}',
                style: TextStyle(
                    decoration: TextDecoration.underline, fontSize: 14)),
            onTap: () async {
              await launch('${person.homepage}');
            },
          ),
          Divider(height: 20),
        ],
      );
    } else {
      return Container();
    }
  }
}
