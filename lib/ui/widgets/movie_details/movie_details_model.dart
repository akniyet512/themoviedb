import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  String _locale = "";
  late DateFormat _dateFormat;

  MovieDetailsModel(this.movieId);

  MovieDetails? get movieDetails => _movieDetails;

  Future<void> setupLocale(BuildContext context) async {
    final String locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(locale);
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails =
        await _apiClient.movieDetails(movieId: movieId, locale: _locale);
    notifyListeners();
  }
}
