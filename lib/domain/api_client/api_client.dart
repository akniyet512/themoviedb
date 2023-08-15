import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
    final Uri url =
        Uri.parse("$_host/authentication/token/new?api_key=$_apiKey");
    final HttpClientRequest request = await _client.getUrl(url);

    final HttpClientResponse response = await request.close();

    final Map<String, dynamic> json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);

    log(json.toString());
    return json["request_token"] as String;
  }

  Future<String> validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final Uri url = Uri.parse(
        "$_host/authentication/token/validate_with_login?api_key=$_apiKey");

    final Map<String, dynamic> parameters = {
      "username": username,
      "password": password,
      "request_token": requestToken,
    };
    final HttpClientRequest request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final HttpClientResponse response = await request.close();
    final Map<String, dynamic> json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    log(json.toString());
    return json["request_token"] as String;
  }

  Future<String> makeSession({
    required String requestToken,
  }) async {
    final Uri url =
        Uri.parse("$_host/authentication/session/new?api_key=$_apiKey");

    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final HttpClientRequest request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;

    request.write(jsonEncode(parameters));
    final HttpClientResponse response = await request.close();

    final Map<String, dynamic> json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((v) => jsonDecode(v) as Map<String, dynamic>);
    log(json.toString());

    return json["session_id"] as String;
  }
}
