class Movie {
  final String? posterPath;
  final DateTime? releaseDate;
  final String? backdropPath;
  final bool adult;
  final String overview;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final double popularity;
  final int voteCount;
  final bool video;
  final double? voteAvarage;

  Movie({
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.adult,
    required this.overview,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAvarage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json["adult"],
      overview: json["overview"],
      genreIds: (json["genre_ids"] as List<dynamic>).map((e) => e as int).toList(),
      id: json["id"],
      originalTitle: json["original_title"],
      originalLanguage: json["original_language"],
      title: json["title"],
      popularity: json["popularity"],
      voteCount: json["vote_count"],
      video: json["video"],
      voteAvarage: json["vote_avarage"],
      releaseDate: releaseDateFromString(json["release_date"]),
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "overview": overview,
      "genre_ids": genreIds,
      "id": id,
      "original_title": originalTitle,
      "original_language": originalLanguage,
      "title": title,
      "popularity": popularity,
      "vote_count": voteCount,
      "video": video,
      "vote_avarage": voteAvarage,
      "release_date": releaseDate,
      "poster_path": posterPath,
      "backdrop_path": backdropPath,
    };
  }

  static DateTime? releaseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) {
      return null;
    }
    return DateTime.tryParse(rawDate);
  }
}
