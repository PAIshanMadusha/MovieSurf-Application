class TvShowModel {
  final int id;
  final bool adult;
  final String name;
  final String originalLanguage;
  final String? posterPath;
  final String firstAirDate;
  final double popularity;
  final String overview;
  final double voteAverage;

  TvShowModel({
    required this.id,
    required this.adult,
    required this.name,
    required this.originalLanguage,
    this.posterPath,
    required this.firstAirDate,
    required this.popularity,
    required this.overview,
    required this.voteAverage,
  });

  //Method to Convert the Json Data into a Dart Object
  factory TvShowModel.formJson(Map<String, dynamic> json) {
    return TvShowModel(
      id: json["id"] ?? 0,
      adult: json["adult"] ?? false,
      name: json["name"] ?? "",
      originalLanguage: json["original_language"] ?? "",
      posterPath: json["poster_path"] as String?,
      firstAirDate: json["first_air_date"] ?? "",
      popularity: (json["popularity"] ?? 0).toDouble(),
      overview: json["overview"] ?? "",
      voteAverage: (json["vote_average"] ?? 0).toDouble(),
    );
  }
}
