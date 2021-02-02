class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.fromJSONList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (final item in jsonList) {
      final movie = new Movie.fromJSONMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Movie.fromJSONMap(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
  }

  String getImgPoster() {
    if (posterPath == null) {
      return 'https://www.metmuseum.org/content/img/placeholders/NoImageAvailableIcon.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }
}
