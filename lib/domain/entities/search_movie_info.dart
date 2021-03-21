import 'package:equatable/equatable.dart';

class SearchMovieInfo with EquatableMixin {
  String posterPath;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  String title;
  String overview;
  String releaseDate;
  bool video;
  bool adult;
  double popularity;
  double voteAverage;
  int voteCount;
  int id;
  List<int> genreIds;

  SearchMovieInfo(
      {this.posterPath,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.title,
      this.overview,
      this.releaseDate,
      this.video,
      this.adult,
      this.popularity,
      this.voteAverage,
      this.voteCount,
      this.id,
      this.genreIds});

  SearchMovieInfo.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    title = json['title'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    video = json['video'];
    adult = json['adult'];
    popularity = json['popularity'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    id = json['id'];

    List<dynamic> genreIdsList = json['genre_ids'];
    genreIds = [];
    if (genreIdsList != null) {
      genreIds.addAll(genreIdsList.map((o) => int.tryParse(o.toString())));
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['poster_path'] = posterPath;
    data['backdrop_path'] = backdropPath;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['title'] = title;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['video'] = video;
    data['adult'] = adult;
    data['popularity'] = popularity;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['id'] = id;
    data['genre_ids'] = genreIds;
    return data;
  }

  @override
  List<Object> get props => [
        posterPath,
        backdropPath,
        originalLanguage,
        originalTitle,
        title,
        overview,
        releaseDate,
        video,
        adult,
        popularity,
        voteAverage,
        voteCount,
        id,
        genreIds,
      ];
}
