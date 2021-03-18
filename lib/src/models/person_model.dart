class Person {
  bool? adult;
  List<String>? alsoKnownAs;
  String? biography;
  String? birthday;
  dynamic deathday;
  int? gender;
  dynamic homepage;
  int? id;
  String? imdbId;
  String? knownForDepartment;
  String? name;
  String? placeOfBirth;
  double? popularity;
  String? profilePath;

  Person({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  String getUniqueIdActor(String id) {
    return '$id-actor';
  }

  Person.fromJSONMap(Map<String, dynamic> json) {
    adult = json['adult'];
    alsoKnownAs = json['also_known_as'].cast<String>();
    biography = json['biography'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    gender = json['gender'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    placeOfBirth = json['place_of_birth'];
    popularity = json['popularity'] / 1;
    profilePath = json['profile_path'];
  }

  String getImgPoster() {
    if (profilePath == null) {
      return 'https://www.adrcdoorcounty.org/wp-content/uploads/2019/05/mystery-person.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
