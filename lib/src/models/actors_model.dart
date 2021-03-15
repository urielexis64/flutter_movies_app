class Cast {
  List<Actor> actors = [];

  Cast();

  Cast.fromJSONList(List<dynamic> jsonList) {
    jsonList.forEach((element) {
      final actor = new Actor.fromJSONMap(element);
      actors.add(actor);
    });
  }
}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  Actor.fromJSONMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['castId'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
  }

  String getImgPoster() {
    if (profilePath == null) {
      return 'https://www.adrcdoorcounty.org/wp-content/uploads/2019/05/mystery-person.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
