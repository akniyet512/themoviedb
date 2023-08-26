import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieListModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();
  int _currentPage = 0;
  int _totalPage = 1;
  bool _isLoadingInProgress = false;
  final List<Movie> _movies = [];

  List<Movie> get movies => List.unmodifiable(_movies);

  Future<void> loadMovies() async {
    if (_isLoadingInProgress || _currentPage >= _totalPage) return;
    _isLoadingInProgress = true;
    final int nextPage = _currentPage + 1;
    try {
      final PopularMovieResponse moviesResponse =
          await _apiClient.popularMovie(page: nextPage, locale: "ru-RU");
      _movies.addAll(moviesResponse.movies);
      _currentPage = moviesResponse.page;
      _totalPage = moviesResponse.totalPages;
      _isLoadingInProgress = false;
      notifyListeners();
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  void onMovieTap(BuildContext context, {required int index}) {
    final int id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.movieDetails,
      arguments: {"id": id},
    );
  }

  Future<void> showMovieAtIndex(int index) async {
    if (index < _movies.length - 1) return;
    await loadMovies();
  }
}
