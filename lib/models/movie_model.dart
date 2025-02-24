class MovieModel {
  final int id;
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final String title;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    required this.id,
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.title,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  //Method to Convert the Json Data into a Dart Object
  factory MovieModel.formJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"] ?? 0,
      adult: json["adult"] ?? false,
      backdropPath: json["backdrop_path"] as String?,
      genreIds: List<int>.from(json["genre_ids"] ?? []),
      originalLanguage: json["original_language"] ?? "",
      originalTitle: json["original_title"] ?? "",
      title: json["title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: (json["popularity"] ?? 0).toDouble(),
      posterPath: json["poster_path"] as String?,
      releaseDate: json["release_date"] ?? "",
      video: json["video"] ?? false,
      voteAverage: (json["vote_average"] ?? 0).toDouble(),
      voteCount: json["vote_count"] ?? 0,
    );
  }
}
