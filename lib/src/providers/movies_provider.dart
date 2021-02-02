import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey = 'd278c593d23e539bae7d6db38e2cbebd';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = new Movies.fromJSONList(decodedData['results']);
    return movies.items;
  }
}
