class Movie {
  int? id;
  String? movie;
  String? image;
  String? imdbUrl;

  Movie({this.id, this.movie, this.image, this.imdbUrl});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    movie = json['movie'];
    image = json['image'];
    imdbUrl = json['imdb_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['movie'] = movie;
    data['image'] = image;
    data['imdb_url'] = imdbUrl;
    return data;
  }
}
