import 'dart:convert';
import 'dart:io';

enum ApiClientExceptionType {
  network,
  auth,
  other,
}

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final HttpClient _client = HttpClient();
  static const String _host = "https://api.themoviedb.org/3";
  static const String _imageUrl = "https:/image.tmdb.org/t/p/w500";
  static const String _apiKey = "ab2ab6408b60ef0a1487d77c7e8fa3a6";

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final String requestToken = await makeToken();
    final String validToken = await validateUser(
      username: username,
      password: password,
      requestToken: requestToken,
    );
    final String sessionId = await makeSession(requestToken: validToken);
    return sessionId;
  }

  Future<String> makeToken() async {
    parser(dynamic json) {
      return (json as Map<String, dynamic>)["request_token"] as String;
    }

    final Uri url =
        Uri.parse("$_host/authentication/token/new?api_key=$_apiKey");
    return await _get(
      url,
      parser,
    );
  }

  Future<String> validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final Map<String, dynamic> parameters = {
      "username": username,
      "password": password,
      "request_token": requestToken,
    };
    parser(dynamic json) {
      return (json as Map<String, dynamic>)["request_token"] as String;
    }

    final Uri url = Uri.parse(
        "$_host/authentication/token/validate_with_login?api_key=$_apiKey");

    return await _post(
      url,
      parser,
      parameters,
    );
  }

  Future<String> makeSession({
    required String requestToken,
  }) async {
    final Map<String, dynamic> parameters = {
      "request_token": requestToken,
    };
    parser(dynamic json) {
      return (json as Map<String, dynamic>)["session_id"] as String;
    }

    final Uri url =
        Uri.parse("$_host/authentication/session/new?api_key=$_apiKey");

    return await _post(
      url,
      parser,
      parameters,
    );
  }

  Future<T> _get<T>(
    Uri url,
    T Function(dynamic json) parser,
  ) async {
    try {
      final HttpClientRequest request = await _client.getUrl(url);

      final HttpClientResponse response = await request.close();

      final Map<String, dynamic> json = await response
          .transform(utf8.decoder)
          .toList()
          .then((value) => value.join())
          .then((v) => jsonDecode(v) as Map<String, dynamic>);
      _validateResponse(response, json);
      final T result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<T> _post<T>(
    Uri url,
    T Function(dynamic json) parser,
    Map<String, dynamic> bodyParameters,
  ) async {
    try {
      final Map<String, dynamic> parameters = bodyParameters;
      final HttpClientRequest request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(parameters));
      final HttpClientResponse response = await request.close();

      final Map<String, dynamic> json = await response
          .transform(utf8.decoder)
          .toList()
          .then((value) => value.join())
          .then((v) => jsonDecode(v) as Map<String, dynamic>);
      _validateResponse(response, json);
      final T result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  void _validateResponse(
    HttpClientResponse response,
    Map<String, dynamic> json,
  ) {
    if (response.statusCode == 401) {
      final int code = json["status_code"] is int ? json["status_code"] : 0;
      if (code == 30) {
        throw ApiClientException(ApiClientExceptionType.auth);
      } else {
        throw ApiClientException(ApiClientExceptionType.other);
      }
    }
  }
}
