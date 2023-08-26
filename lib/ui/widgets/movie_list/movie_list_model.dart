import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  final List<Movie> _movies = [];

  List<Movie> get movies => List.unmodifiable(_movies);

  Future<void> loadMovies() async {
    final PopularMovieResponse moviesResponse =
        await _apiClient.popularMovie(page: 1, locale: "ru-RU");
    _movies.addAll(moviesResponse.movies);
    notifyListeners();
  }

  void onMovieTap(BuildContext context, {required int index}) {
    final int id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: {"id": id},
    );
  }
}
