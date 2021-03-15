import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/actors_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/person_model.dart';

class MoviesProvider {
  String _apiKey = 'd278c593d23e539bae7d6db38e2cbebd';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = [];

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJSONList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_loading) return [];

    _loading = true;

    _popularsPage++;

    print(_popularsPage);

    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '$_popularsPage'});

    final response = await _processResponse(url);

    _populars.addAll(response);
    popularsSink(_populars);

    _loading = false;

    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final cast = new Cast.fromJSONList(decodedData['cast']);

    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
      'include_adult': 'true'
    });

    return await _processResponse(url);
  }

  Future<Person> getPerson(String personId) async {
    final url = Uri.https(_url, '3/person/$personId', {
      'api_key': _apiKey,
      'language': _language,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final person = new Person.fromJSONMap(decodedData);
    return person;
  }
}
