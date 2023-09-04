import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieDetailsModel extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  final int movieId;
  MovieDetails? _movieDetails;
  String _locale = "";
  bool _isFavorite = false;
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  MovieDetailsModel(this.movieId);

  MovieDetails? get movieDetails => _movieDetails;
  bool get isFavorite => _isFavorite;

  Future<void> setupLocale(BuildContext context) async {
    final String locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    await loadDetails();
  }

  Future<void> loadDetails() async {
    _movieDetails =
        await _apiClient.movieDetails(movieId: movieId, locale: _locale);
    final String? sessionId = await _sessionDataProvider.getSessionId();
    if (sessionId != null) {
      _isFavorite =
          await _apiClient.isFavourite(movieId: movieId, sessionId: sessionId);
    }
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    final String? sessionId = await _sessionDataProvider.getSessionId();
    final int? accountId = await _sessionDataProvider.getAccountId();
    if (sessionId == null || accountId == null) {
      return;
    }
    _isFavorite = !_isFavorite;
    notifyListeners();
    await _apiClient.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: ApiClientMediaType.movie,
      mediaId: movieId,
      isFavorite: _isFavorite,
    );
  }
}
