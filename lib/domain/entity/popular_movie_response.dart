import 'package:themoviedb/domain/entity/movie.dart';

class PopularMovieResponse {
  final int page;
  final List<Movie> movies;
  final int totalResults;
  final int totalPages;

  PopularMovieResponse({
    required this.page,
    required this.movies,
    required this.totalResults,
    required this.totalPages,
  });

  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) {
    return PopularMovieResponse(
      page: json["page"],
      movies: (json["results"] as List<dynamic>)
          .map((e) => Movie.fromJson(e))
          .toList(),
      totalResults: json["total_results"],
      totalPages: json["total_pages"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "movies": movies,
      "total_results": totalResults,
      "total_pages": totalPages,
    };
  }
}
